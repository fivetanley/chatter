require( [ 'viewmodels/chat_view', 'viewmodels/name_picker' ],
    function( ChatView, NamePicker ) {
    var namePicker = new NamePicker( '#name_picker' )

  namePicker.on( 'done', function( name ) {
    chatView = new ChatView( { el: '#chat', senderName: name } )
    chatView.changeName( name )
    chatView.show()
  })
})
