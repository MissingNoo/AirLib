import net from 'node:net';
import { randomUUID } from "node:crypto";
const server = net.createServer((c) => {
  // 'connection' listener.
  console.log('client connected');
  c.setEncoding('utf8');
  c.on('data', (d) => {
    const data = JSON.parse(d);
    console.log(data);
    const json = {type : "", message : {}};
    switch (data.type) {
        case "connect": {
            json.type = "uuid";
            json.message.uuid = randomUUID();
            json.message.rmanager = false;
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
    c.on('error', (err) => {
        console.error('Connection error:', err);
    });
  });
  
  c.on('end', () => {
    console.log('client disconnected');
  });

});
server.on('error', (err) => {
  throw err;
});
server.listen(36692, () => {
  console.log('server bound');
});
