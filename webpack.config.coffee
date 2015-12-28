vue = require('vue-loader')
webpack = require('webpack')
path = require('path')

module.exports = {
  # entry: './public/coffee/main.coffee'
  output:
    path: path.resolve(__dirname, 'public')
    # publicPath: '/static/'
    filename: '[name].js'

  module:
    loaders: [
      {
        test: /\.coffee$/
        loader: 'coffee-loader'
      }
      {
        test: /\.vue$/
        loader: 'vue'
      }
      {
        test: /\.js$/
        exclude: /node_modules|vue\/dist|vue-router\/|vue-loader\/|vue-hot-reload-api\//
        loader: 'babel'
      }
    ]
  babel:
    presets: ['es2015']
    plugins: ['transform-runtime']
  resolve:
    extensions: ['', '.js', '.coffee', '.scss', '.css']
}

if (process.env.NODE_ENV is 'production')
  module.exports.plugins = [
    new webpack.DefinePlugin
      'process.env':
        NODE_ENV: '"production"'
    new webpack.optimize.UglifyJsPlugin
      compress:
        warnings: false
    new webpack.optimize.OccurenceOrderPlugin()
  ]
else
  module.exports.devtool = '#source-map'
