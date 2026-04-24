const path = require("path");
const NodePolyfillPlugin = require("node-polyfill-webpack-plugin");
const TerserPlugin = require("terser-webpack-plugin");

module.exports = {
  mode: "production",
  entry: "./src/index.ts",
  devtool: false,
  optimization: {
    minimizer: [
      new TerserPlugin({
        terserOptions: {
          format: {
            ascii_only: true,
          },
        },
      }),
    ],
  },
  module: {
    rules: [
      {
        test: /\.m?js$/,
        resolve: {
          fullySpecified: false,
        },
      },
      {
        test: /\.tsx?$/,
        use: "ts-loader",
        exclude: /node_modules/,
      },
    ],
  },
  resolve: {
    extensions: [".tsx", ".ts", ".js"],
  },
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "./dist"),
  },
  plugins: [
    new NodePolyfillPlugin({
      additionalAliases: ["process", "buffer", "Buffer"],
    }),
  ],
  stats: {
    errorDetails: true,
  },
};
