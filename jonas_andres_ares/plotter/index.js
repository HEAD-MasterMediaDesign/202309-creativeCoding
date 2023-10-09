
// PERCENTAGE POSITIONS
const PENCIL_UP = 90;
const PENCIL_DOWN = 60;


import { exec, execSync } from "child_process";
import * as fs from 'fs';
import { createRequire } from "module";
const require = createRequire(import.meta.url);
const chokidar = require("chokidar");

import * as oscBridge from "./oscBridge.js"

// Tidy up: Delet all previous SVG Files
const fileList = fs.readdirSync("./");
for (const file of fileList) {
  if(file.endsWith(".svg")){
    fs.unlinkSync(file);
  }
}

// Start processing sketch
const childProcess = exec("processing-java --sketch=`pwd` --run");
childProcess.stdout.on("data", (data) => {
  console.log(data); // Print stdout data from the child process
});
childProcess.stderr.on("data", (data) => {
  console.error(data); // Print stderr data from the child process
});
childProcess.on("close", (code) => {
  console.log(`Child process exited with code ${code}`);
});

execSync(`axicli -d ${PENCIL_DOWN} -u ${PENCIL_UP} --mode manual --manual_cmd raise_pen`);
execSync(`axicli -d ${PENCIL_DOWN} -u ${PENCIL_UP} --mode manual --manual_cmd walk_home`);

// Start watching for new svg files to print
chokidar.watch(".", { ignored: "node_modules" }).on("add", (path) => {
  if (path.endsWith(".svg")) {
  execSync(`axicli ${path} -d ${PENCIL_DOWN} -u ${PENCIL_UP}`, { encoding: 'utf-8' });
  fs.unlinkSync(path);
  oscBridge.send("drawing-complete")
  }
});

// Force pencil to go up on interrupt
process.once('SIGINT', () => {
  execSync(`axicli -d 60 -u 90 --mode manual --manual_cmd raise_pen`);
})


// var udpPort = new osc.UDPPort({
//   localAddress: "127.0.0.1",
//   localPort: 2000,
//   metadata: true,
// });

// // Listen for incoming OSC messages.
// udpPort.on("message", function (oscMsg, timeTag, info) {
//   console.log("An OSC message just arrived!", oscMsg);
//   console.log("Remote info is: ", info);
// });

// // Open the socket.
// udpPort.open();

// // When the port is read, send an OSC message to, say, SuperCollider
// udpPort.on("ready", function () {
//   udpPort.send(
//     {
//       address: "/s_new",
//       args: [
//         {
//           type: "s",
//           value: "default",
//         },
//         {
//           type: "i",
//           value: 100,
//         },
//       ],
//     },
//     "127.0.0.1",
//     1000
//   );
// });

// setTimeout(() => {
//   console.log("Delayed for 6 second.");
//   udpPort.send(
//     {
//       address: "/s_new",
//       args: [
//         {
//           type: "s",
//           value: "default",
//         },
//         {
//           type: "i",
//           value: 100,
//         },
//       ],
//     },
//     "127.0.0.1",
//     1000
//   );
// }, 6000);
