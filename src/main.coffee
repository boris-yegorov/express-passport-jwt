app = require "./app"
http = require "http"

server = http.createServer app

onListen = (err) ->
  if err
    console.error err
    process.exit 1

  address = server.address()

  console.log "listening on port #{address.port}"

server.once "error", (err) ->
  return onListen err

port = 3000

server.listen port, onListen
