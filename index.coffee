app = require './server/app'
port = process.env.PORT or 3000

env = app.get 'env'

app.listen port, ->
  console.log "Express server listening on port #{port}, env is #{env}"
