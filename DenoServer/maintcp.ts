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
const server = net.createServer((c) => {
    c.setMaxListeners(0);
  // 'connection' listener.
  console.log('client connected');
  c.setEncoding('utf8');
  c.on('data', (r) => {
    try {
        handle_data(c, r);
    } catch (error) {
        console.error(error)
    }
    
  });
  c.on('error', (err) => {
    console.error('Connection error:', err);
  });
  c.on('end', () => {
    console.log('client disconnected');
  });

});
server.on('error', (err) => {
  //throw err;
  console.error('Connection error:', err);
});
server.listen(36692, () => {
  console.log('server bound');
});

function handle_data(c, d)
    {
        const data = JSON.parse(d);
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
                c.write(JSON.stringify(json) + ";");
                c.pipe(c);
            }
        }
        
      }