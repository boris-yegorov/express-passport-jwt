express = require "express"
passportJwtMiddleware = require "./middleware/passport-jwt"
passportLocalMiddleware = require "./middleware/passport-local"

routes = express()

routes.get "/public", (req, res, next) ->
  res.json message: "you in public route"

routes.get "/private", passportJwtMiddleware
routes.get "/private", (req, res, next) ->
  res.json message: "you in private route"

routes.post "/login", passportLocalMiddleware

module.exports = routes
