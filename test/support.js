!function() {

  global.jQuery = global.$ = require( 'jquery' )

  var chai = require( 'chai' )
    , chaiSinon = require( 'sinon-chai' )
    , chaiJquery = require( 'chai-jquery' )
    , expect = chai.expect
    , sinon = require( 'sinon' )

  chai.use( chaiSinon )
  chai.use( chaiJquery )

  global.sinon = sinon
  global.expect = expect

}();
