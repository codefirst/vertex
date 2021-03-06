imodule.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-cssnext'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}
// plugins:
// postcss-import: {}
// postcss-cssnext: {}
