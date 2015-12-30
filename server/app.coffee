path = require 'path'
# isPro = process.env.NODE_ENV is 'production'
# isDev = !isPro



# uuid = require 'node-uuid'
# session = require 'express-session'
# bodyParser = require 'body-parser'
# cookieParser = require 'cookie-parser'
# Redis = require 'ioredis'


express = require 'express'
app = express()
app.set('x-powered-by', false)


app.use require('connect-timeout')('15s')
app.use require('serve-favicon')(path.join(__dirname, '../public/favicon.ico'))



# 模板引擎
app.set('view engine', 'jade')


module.exports = app
