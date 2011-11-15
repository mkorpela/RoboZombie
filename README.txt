WHAT YOU NEED:
robot framework
node.js
zombie.js
node-xmlrpc
coffeescript

.. you need to figure out how to install/compile those things by your self.

HOW TO RUN THE TEST:
#start robozombie
coffee robozombie.coffee

# or if you want javascript..
coffee -c robozombie.coffee
node robozombie.js


cd robo

#start the server
python server.py start

#run the test
pybot test.txt

