$ = require ( 'jquery' )
World = require( './world' ).World
chai = require( 'chai' )
chaiJquery = require( 'chai-jquery' )
global.jQuery = $
chaiSinon = require( 'sinon-chai' )
chai.use( chaiJquery )
chai.use( chaiSinon )
expect = chai.expect

module.exports = ()->

  global.$ = $
  global.expect = expect

  @World = World
