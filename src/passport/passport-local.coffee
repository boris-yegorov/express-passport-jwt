passport = require "passport"
LocalStrategy = require "passport-local"
users = require "./../users"
_ = require "lodash"

localStrategy = new LocalStrategy({
  usernameField: "email",
  passwordField: "password"
}, (username, password, done) ->
  index = _.findIndex(users, (obj) ->
    _.isEqual(obj, {email: username, password: password})
  )
  if index isnt -1
    done null, users[index]
  else
# authentication failed
    done null, false
)

passport.use localStrategy

module.exports = passport
