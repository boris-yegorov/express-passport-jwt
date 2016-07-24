request = require "supertest-as-promised"
expect = require("chai").expect
app = require "../src/app"
users = require "../src/users"

validToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5hbWUxQG5hbWUxLm5hbWUxIiwiaWF0IjoxNDY5MzcyNDQ5fQ.ZM0QfcVr9u6Rp1afTNozkyVuicKe57b7Gpz4D0CrPgM"
invalidToken = "bad#{validToken}"
validUser =
  email: "name1@name1.name1"
  password: "password"
invalidUser =
  email: "name1@name1.name1"
  password: "12345678"

describe "app", () ->
  it "should have access to public route", ->
    return request app
    .get "/public"
    .expect 200
    .expect message: "you in public route"

  it "should receive error message if token invalid", () ->
    return request app
    .get "/private"
    .set("Authorization", "Bearer #{invalidToken}")
    .expect 401
    .expect error: "unauthorized"

  it "should receive error message if token absent", () ->
    return request app
    .get "/private"
    .expect 401
    .expect error: "unauthorized"

  it "should successful access api endpoint", () ->
    return request app
    .get "/private"
    .set("Authorization", "Bearer #{validToken}")
    .expect 200
    .expect message: "you in private route"

  it "should successful login and receive token", () ->

    return request app
    .post "/login"
    .send validUser
    .expect 200
    .expect (res) ->
      expect(res.body.token).to.not.be.undefined

  it "should receive error message at login", () ->
    return request app
    .post "/login"
    .send invalidUser
    .expect 401
    .expect error: "unauthorized"
