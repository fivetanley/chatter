!function() {

  var Isolate = require( 'isolate' )
  global.isolate = Isolate.isolate

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

  Isolate.mapType({
    'object': {}
  , 'function': function(){}
  })

  var sanitizeStub = sinon.stub()

  Isolate.mapAsFactory( /validator/, function(){
    return {
      sanitize: sanitizeStub
                  .returns( { xss:
                    function() { return sanitizeStub.args[0][0] } } )
    }
  })

}();
