express = require "express"
bodyParser = require "body-parser"
cookieParser = require "cookie-parser"
passportLocal = require "./passport/passport-local"
passportJwt = require "./passport/passport-jwt"
routes = require "./routes"

app = express()

app.use cookieParser()
app.use bodyParser.urlencoded(extended: false)
app.use bodyParser.json()
app.use passportLocal.initialize()
app.use passportJwt.initialize()
app.use routes

app.use (err, req, res, next) ->
  console.log err.message
  res.status(err.status || 500);
  res.send({error: err.message});

module.exports = app
