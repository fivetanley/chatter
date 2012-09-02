!function() {

  var $ = require( 'jquery' )
    , EventEmitter = require( 'eventemitter2' )

  function NamePicker( el ) {
    var self = this
    this.el = el
    this.$el = $( el )
    this.$nameForm = this.$el.children( 'form' )
    this.$error = this.$el.children( '.error' )
    this.$nameInput = this.$nameForm.children( '[name="name"]' )
    this.$nameForm.submit( function( event ) {
      event.preventDefault()
      var value = self.$nameInput.val().trim()
      if ( !value ) {
        self.$error.text( 'Please input a name that is not empty!' )
        self.$error.show()
        return
      }
      self.emit( 'done', self.$nameInput.val() )
      self.hide()
    })
  }

  NamePicker.prototype = new EventEmitter({
    wildcard: true
  , delimiter: ':'
  })

  NamePicker.prototype.show = function() {
    this.$el.show()
  }

  NamePicker.prototype.hide = function() {
    this.$el.hide()
  }

  module.exports = NamePicker

}();
