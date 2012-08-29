$ = require ( 'jquery' )
World = require( './world' ).World
chai = require( 'chai' )
sinon = require( 'sinon' )
chaiJquery = require( 'chai-jquery' )
global.jQuery = $
chaiSinon = require( 'sinon-chai' )
chai.use( chaiJquery )
chai.use( chaiSinon )
expect = chai.expect

module.exports = ()->

  global.sinon = sinon
  global.expect = expect

  @World = World
