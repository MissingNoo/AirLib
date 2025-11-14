const encoder = new TextEncoder();
const decoder = new TextDecoder();
//import { server } from "./main.ts";
import {Player} from "./Player.ts";
export function sendMessage(
  type: string,
  // deno-lint-ignore no-explicit-any
  message: any,
  player: Player,
): void {
  const data = {
    type: type,
    message: JSON.stringify(message),
  };
  const j = JSON.stringify(data);
  console.log("Sending: " + JSON.stringify(data))
  //player.socket.write("\n" + JSON.stringify(data) + ";");
  player.socket.write(encoder.encode("\n" + JSON.stringify(data) + ";"))
  //player.socket.pipe(player.socket);
}
