xmlrpc = require 'xmlrpc'
if not xmlrpc
    console.log 'Requires node-xmlrpc'
    console.log 'npm install xmlrpc'

zombie = require 'zombie'
if not zombie
    console.log 'Requires Zombie.js'

pass = (callback) -> callback(null, {status: 'PASS'})
fail = (callback) -> callback(null, {status: 'FAIL'})

class RoboZombie
    constructor: (@browser = null) ->

    open_browser_callback: (callback) ->
        robozombie = this
        (err, browser, status) ->
          robozombie.browser = browser
          pass(callback)

    Open_Browser: (params, callback) ->
        url = params[1][0]
        zombie.visit(url, { debug: true}, @open_browser_callback(callback))

    Close_Browser: (params, callback) ->
        pass(callback)

    Input_Text: (params, callback) ->
        identifier = params[1][0]
        text = params[1][1]
        @browser.fill(identifier, text)
        pass(callback)

    Click_Button: (params, callback) ->
        @browser.pressButton(params[1][0], (err) -> pass(callback))

    Location_Should_Be: (params, callback) ->
        location = params[1][0]
        @browser.location
        if @browser.location.href.split("?",1)[0] == location
          pass(callback)
        else
          console.log(@browser.location.href.split("?",1)[0])
          console.log(location)
          fail(callback)

    Title_Should_Be: (params, callback) ->
        title = params[1][0]
        if @browser.text("title") == title
          pass(callback)
        else
          fail(callback)

class RemoteServer
    constructor: (@library) ->

    get_keyword_names: (params, callback) ->
        names = (name.replace(/\_/g, " ") for name, _ of @library when name[0].toUpperCase() == name[0])
        callback(null, names)

    get_keyword_documentation: (params, callback) ->
        callback(null, "Doqumantsione")

    get_keyword_arguments: (params, callback) ->
        callback(null, ["*args"])

    run_keyword: (params, callback) ->
        @library[params[0].replace(/\s/g, "_")](params, callback)

    create_callback: (name) ->
       remote = this
       (err, params, callback) ->
          remote[name](params, callback)

    start_remote_server: () ->
        server = xmlrpc.createServer({ host: 'localhost', port: 1337 })
        for name, _ of this
          if name not in ["start_remote_server", "library", "create_callback"]
              console.log("Listening for "+name)
              server.on(name, @create_callback(name))
        console.log("Remote server on in port 1337")

new RemoteServer(new RoboZombie()).start_remote_server()
