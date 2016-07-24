passport = require "passport"
passportJwt = require "passport-jwt"
users = require "./../users"
config = require "./../config"
_ = require "lodash"

ExtractJwt = passportJwt.ExtractJwt
Strategy = passportJwt.Strategy

params =
  secretOrKey: config.secret
  jwtFromRequest: ExtractJwt.fromAuthHeaderWithScheme("Bearer")

strategy = new Strategy(
  params
  (payload, done) ->
    email = payload.email
    index = _.findIndex(users, (obj) ->
      obj.email == email
    )
    if index isnt -1
      done null, users[index]
    else
      done null, false, {error: "unauthorized"}
)

passport.use strategy

module.exports = passport