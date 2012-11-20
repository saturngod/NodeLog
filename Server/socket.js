// Load the TCP Library
var HOST_SERVER = "192.168.1.110";
var HOST_PORT = 5400;

var net = require('net');

// Keep track of the chat clients
var clients = [];

// Start a TCP Server
net.createServer(function (socket) {

  // Identify this client
  socket.name = socket.remoteAddress + ":" + socket.remotePort 

  // Put this new client in the list
  clients.push(socket);

  // Send a nice welcome message and announce
  Log(socket.name + " joined\n", socket);
  
  // Handle incoming messages from clients.
  socket.on('data', function (data) {
    Log(socket.name + " " + data+"\n", socket);
  });

  // Remove the client from the list when it leaves
  socket.on('end', function () {
    clients.splice(clients.indexOf(socket), 1);
    Log(socket.name + " left.\n");
  });
  
  // Send a message to all clients
  function Log(message, sender) {
    // Log it to the server output too
    process.stdout.write(message)
  }

}).listen(HOST_PORT,HOST_SERVER);

console.log("Start "+HOST_SERVER+" : "+ HOST_PORT);