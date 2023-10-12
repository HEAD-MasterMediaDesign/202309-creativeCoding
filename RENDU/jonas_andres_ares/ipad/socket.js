let socket = io(host, {
  reconnection: true,
  transports: ["websocket"],
  query: { clientType: "mobile" },
  reconnectionDelay: 100,
});