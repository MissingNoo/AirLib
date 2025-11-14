
const encoder = new TextEncoder();
const decoder = new TextDecoder();

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
    // new connection
    connections.push(connection);
    handle_connection(connection);
  }
  
  async function handle_connection(connection: Deno.Conn) {
    let buffer = new Uint8Array(1024);
    while (true) {
      /*const count = await connection.read(buffer);
      if (!count) {
        // connection closed
        const index = connections.indexOf(connection);
        connections.splice(index, 1);
        break;
      } else {
        // message received
        let message = buffer.subarray(0, count);
        for (const current_connection of connections) {
          if (current_connection !== connection) {
            await current_connection.write(message);
          }
        }
      }*/
        const buf = new Uint8Array(1024);

        await connection.read(buf);
      
        console.log("Server - received: ", decoder.decode(buf));
      
        await connection.write(encoder.encode(JSON.stringify({type:"pong"})))
    }
  }