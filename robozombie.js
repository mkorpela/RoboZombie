var xmlrpc = require('xmlrpc');
if(xmlrpc === undefined) {
  console.log('Requires node-xmlrpc');
  console.log('npm install xmlrpc');
};

var zombie = require('zombie');
if(zombie === undefined) {
  console.log('Requires Zombie.js');
}

var state = {'browser':null};

var server = xmlrpc.createServer({ host: 'localhost', port: 1337 });

server.on('get_keyword_names', function (err, params, callback) {
  console.log('get keyword names received!!!');
  callback(null, ['Open Browser', 'Input Text', 'Click Button',
                  'Location Should Be', 'Title Should Be',
                  'Close Browser']);
});

server.on('get_keyword_documentation', function (err, params, callback) {
  callback(null, "Doccu");
});

server.on('get_keyword_arguments', function (err, params, callback) {
  callback(null, ["*args"]);
});

server.on('run_keyword', function (err, params, callback) {
  console.log('Run keyword "' + params + '"');
  if(params[0] == 'Open Browser'){
    console.log('Open browser!');
    console.log(params[1][0]);
    zombie.visit(params[1][0], function (err, browser, status) {
      console.log('is doing this');
      state['browser'] = browser;
      console.log(err);
      console.log(browser);
      callback(null, {'status': 'PASS'});
    });
  } else if (params[0] == 'Input Text' && 1 == 0) {
    console.log(state);
    state['browser'] = state['browser'].fill(params[1][0], params[1][1]);
  } else { 
    callback(null, {'status':'PASS'});
  }
});

console.log('Robozombie server is up and running on port 1337');
