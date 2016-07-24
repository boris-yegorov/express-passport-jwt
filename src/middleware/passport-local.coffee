passportLocal = require "../passport/passport-local"
jwt = require "jsonwebtoken"
config = require "../config"

module.exports = (req, res, next) ->
  passportLocal.authenticate("local", (err, user, info) ->
    if err
      next err
    else
      if user
        token = jwt.sign email: user.email, config.secret
        res.json token: token
      else
        res
        .status 401
        .json error: "unauthorized"
  )(req, res, next)
  