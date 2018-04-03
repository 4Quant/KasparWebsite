var path = require('path');
var webpack = require('webpack');

module.exports = {
  entry: {
    site: './source/javascripts/webpack/main.js',
  },

  resolve: {
    root: __dirname + '/source/javascripts/webpack',
  },

  output: {
    path: __dirname + '/.tmp/dist',
    filename: 'main.bundle.js',
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        loader: 'babel-loader',
        exclude: /node_modules/
      },
      {
        test: /\.(png|jpg|gif|svg)$/,
        loader: 'file-loader',
        options: {
          name: '[name].[ext]?[hash]'
        }
      }
    ]
  },
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.common.js'
    }
  }
};
