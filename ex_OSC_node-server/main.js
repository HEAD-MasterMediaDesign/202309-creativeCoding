const osc = require('node-osc'),
    io = require('socket.io').listen(8081)

let oscServer, oscClient

io.on('connection', socket => {
  socket.on('config', obj => {
    console.log('config', obj)
    oscServer = new osc.Server(obj.server.port, obj.server.host)
    oscClient = new osc.Client(obj.client.host, obj.client.port)

    oscClient.send('/status', socket.id + ' connected')

    oscServer.on('message', (msg, rinfo) => {
      socket.emit('message', msg)
      console.log('sent OSC message to WS', msg, rinfo)
    })
  })
  socket.on('message', obj => {
    let toSend = obj.split(' ')
    oscClient.send(...toSend)
    console.log('sent WS message to OSC', toSend)
  })
  socket.on("disconnect", () => {
    oscServer.kill()
  })
})
