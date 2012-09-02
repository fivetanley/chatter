({
  baseUrl: '../lib/public/js',
  name: 'app',
  out: '../lib/public/js/main.js',
  include: [ 'almond', 'app' ],
  cjsTranslate: true,
  findNestedDependencies: false,
  paths: {
    'almond': 'vendor/almond',
    'jquery': 'vendor/jquery',
    'socket.io-client':
      '../../../node_modules/socket.io-client/dist/socket.io',
    'eventemitter2':
      'vendor/eventemitter2/lib/eventemitter2'
  },
  optimize: 'none'
})
