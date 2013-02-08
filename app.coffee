###
Module dependencies.
###

express = require("express")
routes = require("./routes")
upload = require("./routes/upload")
http = require("http")
path = require("path")
app = express()
uploadDir = './public/uploads'

app.configure ->
  app.set "port", process.env.PORT or 8235
  app.set "views", __dirname + "/views"
  app.set "plists", __dirname + "/public/plists"
  app.set "uploads", __dirname + "/public/uploads"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger "dev"
  app.use express.bodyParser
    uploadDir: uploadDir
    keepExtensions: true
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()

app.get "/", routes.index
app.post "/", upload.index

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
