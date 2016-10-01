const ExtractTextPlugin = require("extract-text-webpack-plugin")
const CopyWebpackPlugin = require("copy-webpack-plugin")
module.exports = {
  entry: ["./static/css/app.css",
          "./components/app.js"],
  output: {
    path: "../priv/static",
    filename: "js/app.js"
  },
  module: {
    loaders: [{
      test: /\.js$/,
      exclude: /node_modules/,
      include: __dirname,
      loader: ["babel"],
      query: {
        presets: ["es2015", "react"]
      }
    }, {
      test: /\.css$/,
      loader: ExtractTextPlugin.extract("style", "css")
    }]
  },
  plugins: [
    new ExtractTextPlugin("css/app.css"),
    new CopyWebpackPlugin([{ from: "./static/assets" }])
  ],
  resolve: {
    modulesDirectories: [ "node_modules", __dirname + "/static/js" ]
  }
}
