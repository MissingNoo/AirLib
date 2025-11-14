
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
import net from 'node:net';
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

const server = Deno.listen({
  hostname: "127.0.0.1",
  port: 36692,
  transport: "tcp",
});
const connections: Deno.Conn[] = [];
/*for await (const conn of listener) {

  const buf = new Uint8Array(1024);

  await conn.read(buf);

  console.log("Server - received: ", decoder.decode(buf));

  await conn.write(encoder.encode(JSON.stringify({type:"pong"})))
}*/

for await (const connection of server) {
    connections.push(connection);
    handle_connection(connection);
}
  
async function handle_connection(conn: Deno.Conn) {
    const buf = new Uint8Array(1024);
    while (true) {
        const bytesRead = await conn.read(buf);
        if (bytesRead === null) break; // Connection closed
        const data = JSON.parse(decoder.decode(buf.subarray(0, bytesRead)));
        handle_data(conn, data)
    }
}

function handle_data(c, data)
    {
        if (data.type != "ping") {
            console.log(data);            
        }
        const json = {type : "", message : {}};
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
                socket : c,
                uuid: gen_uuid,
                name: gen_uuid,
                room: "",
                x: 0,
                y: 0,
                loggedIn: false,
                lastping: moment(moment.now()),
            };        
            let isRmanager = players.length == 0;
            isRmanager = false; //we ignore this for now
            players.push(p);
            redis.set("PlayerList", listPlayers().toString());
            sendMessage("uuid", { uuid: gen_uuid, rmanager : isRmanager }, p);
            if (isRmanager) {
              console.log("[MAIN] Colision manager started");
              rmanagerdata = rinfo;
            }
            console.log(`[Main] Player ${gen_uuid} connected`);
        }
        //#endregion
        if (player) {
            console.log(player.loggedIn)
            switch (data.type) {
                case "login": {
                    PlayerLogin(player, data.username, data.passwordhash);
                    break;
                  }c
                  case "register": {
                    RegisterPlayer(player, data.username, data.passwordhash);
                    break;
                  }
                case "ping":{
                    json.type = "pong";
                    break;}
            }
            if (json.type != "") {
                json.message = JSON.stringify(json.message);
                c.write(encoder.encode(JSON.stringify(json)))
                //c.write(JSON.stringify(json) + ";");
                //c.pipe(c);
            }
        }
        
      }

  