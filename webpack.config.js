const path = require('path');
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const ManifestPlugin = require('webpack-manifest-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');


module.exports = (env, argv) => {
  const isProduction = argv.mode === 'production';
  return {
    context: path.resolve(__dirname, 'app/javascript/packs'),
    entry: [
      'pages/tasks/index'
    ].reduce((obj, key) => {
      obj[key] = [
        '@babel/polyfill',
        path.resolve(__dirname, 'app/javascript/packs', key)
      ];
      return obj;
    }, {}),
    output: {
      path: path.resolve(__dirname, 'public/packs'),
      filename: isProduction ? '[name]-[contentHash].js' : '[name]-[hash].js',
    },
    module: {
      rules: [
        {test: /\.(css|sass|scss)$/, use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader']},
        {
          test: /\.(png|jpg|gif)$/,
          use: [
            {
              loader: 'file-loader',
              options: {
                outputPath: 'images/',
                name: '[name]-[hash].[ext]',
              },
            },
          ],
        },
        {
          test: /\.vue$/,
          exclude: /node_modules/,
          loader: 'vue-loader',
          options: {
            extractCSS: true,
          },
        },
        {
          test: /\.ts$/,
          exclude: /node_modules/,
          use: [
            {
              loader: 'ts-loader',
              options: { appendTsSuffixTo: [/\.vue$/] }
            }
          ]
        },
        {
          test: /\.(pug)$/i,
          oneOf: [
            {
              resourceQuery: /^\?vue/,
              use: 'pug-plain-loader'
            },
            {
              use: 'pug-loader'
            }
          ]
        },
      ],
    },
    plugins: [
      new VueLoaderPlugin(),
      new ManifestPlugin(),
      new MiniCssExtractPlugin({filename: '[name]-[contentHash].css'}),
    ],
    devServer: {
      publicPath: '/packs/',
      historyApiFallback: true,
      port: 3035,
    },
  };
}
