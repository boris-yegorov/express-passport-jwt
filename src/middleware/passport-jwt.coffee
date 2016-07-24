passportJwt = require "../passport/passport-jwt"

module.exports = (req, res, next) ->
  passportJwt.authenticate("jwt", (err, user, info) ->
    if err
      res
      .status 401
      .json err.message
    else
      if user
        next()
      else
        res
        .status 401
        .json error: "unauthorized"
  )(req, res, next);
  