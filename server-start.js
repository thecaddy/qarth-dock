var forever = require('forever-monitor');


var child = new (forever.Monitor)('./hook.js', {
  silent: false,
  options: []
});

child.on('exit', function () {
  console.log('hook.js has exited');
});

child.start();

console.log("Server Started");
