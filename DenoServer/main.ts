/// <reference lib="deno.ns" />
import {server_port} from "./config.ts";
import { HandleChatCommand } from "./chat.ts";
import {
  createRoom,
  getRoomByCode,
  getRoomList,
  sendMessageToRoom,
} from "./Room.ts";
const encoder = new TextEncoder();
const decoder = new TextDecoder();
import {
  addFriend,
  getFriendList,
  PlayerLogin,
  RegisterPlayer,
} from "./mongo.ts";
import { sendMessage } from "./misc.ts";
import { redis } from "./redis.ts";
import net from "node:net";
import moment from "moment";
import { randomUUID } from "node:crypto";
import {
  disconnectAfk,
  disconnectPlayer,
  findPlayerByName,
  joinRoom,
  leaveRoom,
  listPlayers,
  Player,
  players,
} from "./Player.ts";
let rmanagerdata:Player;
const server = Deno.listen({
  hostname: "127.0.0.1",
  port: 36692,
  transport: "tcp",
});
const connections: Deno.Conn[] = [];
for await (const connection of server) {
  connections.push(connection);
  handle_connection(connection);
}
async function handle_connection(conn: Deno.Conn) {
  const buf = new Uint8Array(1024);
  while (true) {
    let bytesRead;
    try {
      bytesRead = await conn.read(buf);
      if (bytesRead === null) break; // Connection closed
      const data = JSON.parse(decoder.decode(buf.subarray(0, bytesRead)));
      handle_data(conn, data);
    } catch (error) {
      console.log(error);
    }
  }
}

function handle_data(c:Deno.Conn, data:any) {
  if (data.type != "ping" && data.type != "movePlayer") {
    //console.log(data);
  }
  const json = { type: "", message: {} };
  const player = players.find(
    (player) => player.uuid === data.uuid,
  );
  //#region player login
  if (data.type == "connect") {
    if (data.uuid !== "") { //user have an uuid set for the client already
      const existingPlayer = players.find(
        (player) => player.uuid === data.uuid, //find the player
      );
      if (existingPlayer) {
        existingPlayer.socket = c;
        console.log(`[Main] Player ${data.uuid} reconnected`);
        return;
      } else {
        console.log(
          `[Main] Player tried logging in with uuid ${data.uuid} not found, creating new player`,
        );
      }
    }
    const gen_uuid = randomUUID();
    const p: Player = {
      socket: c,
      uuid: gen_uuid,
      name: gen_uuid,
      room: "",
      x: 0,
      y: 0,
      loggedIn: false,
      lastping: moment(moment.now()),
    };
    //let isRmanager = players.length == 0;
    let isRmanager = rmanagerdata === undefined || !rmanagerdata.loggedIn;
    players.push(p);
    redis.set("PlayerList", listPlayers().toString());
    sendMessage("uuid", { uuid: gen_uuid, rmanager: isRmanager }, p);
    if (isRmanager) {
      console.log("[MAIN] Colision manager started");
      rmanagerdata = p;
      rmanagerdata.loggedIn = true;
    }
    console.log(`[Main] Player ${gen_uuid} connected`);
  }
  //#endregion
  if (player) {
    switch (data.type) {
      case "login":
        {
          PlayerLogin(player, data.username, data.passwordhash);
          break;
        }
        c;
      case "register": {
        RegisterPlayer(player, data.username, data.passwordhash);
        break;
      }
      case "ping": {
        json.type = "pong";
        break;
      }
      case "newRoom": {
        const room = createRoom(
          data.roomName,
          data.password,
          data.maxPlayers,
          data.roomType,
          data.joinRequest,
        );
        if (room) {
          sendMessage(
            "roomCreated",
            { roomName: data.roomName, roomCode: room.code },
            player,
          );
        }
        break;
      }
      case "joinRoom": {
        joinRoom(player, data.roomName);
        break;
      }

      case "joinCode": {
        const rname = getRoomByCode(data.roomCode);
        console.log(data.roomCode);
        if (rname) {
          joinRoom(player, rname.RoomName);
        }
        break;
      }

      case "leaveRoom": {
        leaveRoom(player);
        break;
      }
      case "movePlayer": {
        player.x = data.x;
        player.y = data.y;
        sendMessageToRoom(
          player.room,
          "playerMoved",
          { uuid: player.uuid, x: player.x, y: player.y },
          player,
        );
        sendMessage(
          "playerMoved",
          { uuid: player.uuid, x: player.x, y: player.y },
          rmanagerdata,
        );
        break;
      }

      case "disconnect": {
        if (player == rmanagerdata) {
          rmanagerdata.loggedIn = false;
          console.log("[Main] Collision manager is gone!");
        }
        disconnectPlayer(player);
        break;
      }

      case "getRoomList":
        sendMessage(
          "roomList",
          {
            roomList: getRoomList(),
          },
          player,
        );
        break;

      case "chatMessage": {
        const msg: string = data.message;
        if (msg.charAt(0) == "/") {
          HandleChatCommand(player, msg);
        } else {
          sendMessageToRoom(
            player.room,
            "chatMessage",
            { player: data.player, message: data.message },
            player,
            true,
          );
        }
        break;
      }

      case "addFriend": {
        const friend = findPlayerByName(data.player);
        if (friend) {
          sendMessage(
            "addFriend",
            { from: player.name },
            friend,
          );
          console.log(`${player.name} sent a friend request to ${friend.name}`);
        }
        break;
      }

      case "acceptFriend": {
        addFriend(player, data.player);
        break;
      }

      case "getFriendList": {
        getFriendList(player);
        break;
      }

      default:
        console.log(`[Main] unhandled ${data.type}`);
        break;
    }
    if (json.type != "") {
      json.message = JSON.stringify(json.message);
      c.write(encoder.encode(JSON.stringify(json)));
      //c.write(JSON.stringify(json) + ";");
      //c.pipe(c);
    }
  }
}
