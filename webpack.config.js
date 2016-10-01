const ExtractTextPlugin = require("extract-text-webpack-plugin")
const CopyWebpackPlugin = require("copy-webpack-plugin")
module.exports = {
  entry: ["./web/static/css/app.css",
          "./web/static/js/app.js"],
  output: {
    path: "./priv/static",
    filename: "js/app.js"
  },
  module: {
    loaders: [{
      test: /\.js$/,
      exclude: /node_modules/,
      include: __dirname,
      loader: ["babel"],
      query: {
        presets: ["es2015"]
      }
    }, {
      test:/bootstrap-sass[\/\\]assets[\/\\]javascripts[\/\\]/,
      loader: 'imports?jQuery=jquery'
    }, {
      test: /\.css$/,
      loader: ExtractTextPlugin.extract("style", "css")
    }, {
      test: /\.(woff2?|svg)$/,
      loader: 'url?limit=10000'
    }, {
      test: /\.(ttf|eot)$/,
      loader: 'file' }]
  },
  plugins: [
    new ExtractTextPlugin("css/app.css"),
    new CopyWebpackPlugin([{ from: "./web/static/assets" }])
  ],
  resolve: {
    modulesDirectories: [ "node_modules", __dirname + "/web/static/js" ]
  }
}
