import { createRequire } from "module";
const require = createRequire(import.meta.url);
const osc = require("osc");

// export function setListener(listener){
// }

const udpPort = new osc.UDPPort({
  localAddress: "127.0.0.1",
  localPort: 2000,
  metadata: true,
});

// Listen for incoming OSC messages.
udpPort.on("message", function (oscMsg, timeTag, info) {
  console.log("JS: An OSC message just arrived!", oscMsg);
  // console.log("Remote info is: ", info);
});

// Open the socket.
udpPort.open();

// When the port is read, send an OSC message to, say, SuperCollider
udpPort.on("ready", function () {
  // ...
});

export function send(eventName, args = []){
  udpPort.send(
    {
      address: "/" + eventName,
      args: args,
    },
    "127.0.0.1",
    1000
  );
}