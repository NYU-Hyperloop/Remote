var fs = require('fs');
var mosca = require('mosca')

if (process.argv.length != 3) {
	console.log('Usage: node remote.js [JSON config file]');
	process.exit();
}
var config = process.argv[2];

var settings = JSON.parse(fs.readFileSync(config, 'utf8'));

if (settings.secure) {
	settings.secure.keyPath = __dirname + settings.secure.keyPath;
	settings.secure.certPath = __dirname + settings.secure.certPath;
}

var server = new mosca.Server(settings);
server.on('ready', setup);

server.on('clientConnected', function(client) {
	console.log('client connected', client.id);
});

// fired when a message is received
server.on('published', function(packet, client) {
	console.log('Published', packet.payload);
});

// fired when the mqtt server is ready
function setup() {
	console.log('Mosca server is up and running')
	var message = {
		topic: '/hello/world',
		payload: 'abcde',
		qos: 0,
		retain: false
	};

	server.publish(message, function() {
		console.log('done!');
	});
}
