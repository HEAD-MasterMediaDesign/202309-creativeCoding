const express = require("express");
const http = require("http");
const { Server } = require("socket.io");

const app = express();

const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: true,
  },
});

server.listen(3333, () => console.log("Socket-Server listening on *:3333"));

app.get("/", (req, res) => {
  res.send("<h1>Ants socket server working</h1>");
});

io.on("connection", (socket) => {
  console.log("a user connected");

  socket.on("disconnect", () => {
    console.log("User disconnected");
  });

  socket.on("pointsStraight", (data) => {
    // Broadcast the 'pointsStraight' event to the second client
    console.log("Broadcast pointsStraight");
    socket.broadcast.emit("pointsStraight", data);
  });

  socket.on("pointsCurved", (data) => {
    // Broadcast the 'pointsCurved' event to the second client
    console.log("Broadcast pointsCurved");
    socket.broadcast.emit("pointsCurved", data);
  });
});
