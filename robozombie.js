var xmlrpc = require('xmlrpc');
if(xmlrpc === undefined){
  console.log('Requires node-xmlrpc');
  console.log('npm install xmlrpc');
};

var server = xmlrpc.createServer({ host: 'localhost', port: 1337 });

server.on('get_keyword_names', function (err, params, callback) {
  console.log('get keyword names received!!!');
  callback(null, ['Remote Log']);
});

server.on('get_keyword_documentation', function (err, params, callback) {
  callback(null, "Doccu");
});

server.on('get_keyword_arguments', function (err, params, callback) {
  callback(null, ["arg"]);
});

server.on('run_keyword', function (err, params, callback) {
  console.log('Run keyword "' + params + '"');
  callback(null, {'status':'PASS'});
});

console.log('Robozombie server is up and running on port 1337');
