require( [ 'viewmodels/chat_view', 'viewmodels/name_picker' ],
    function( ChatView, NamePicker ) {
  var chatView = new ChatView( { el: '#chat' } )
    , namePicker = new NamePicker( '#name_picker' )

  chatView.hide()
  namePicker.on( 'done', function( name ) {
    chatView.changeName( name )
    chatView.show()
  })
})
