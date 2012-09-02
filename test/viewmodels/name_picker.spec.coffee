NamePicker = require( '../../lib/public/js/viewmodels/name_picker' )

describe 'NamePicker', ->

  namePicker = new NamePicker(
    $ """
      <div>
        <form>
          <input name='name' type='text'/>
        </form>
        <span class='error'></span>
      </div>
      """
  )

  describe 'popping up (showing)', ->

    beforeEach ->
      namePicker.show()

    it 'is visible', ->
      expect( namePicker.$el ).to.be.visible

  describe 'hiding', ->

    beforeEach ->
      namePicker.hide()

    it 'is not visible', ->
      expect( namePicker.$el ).not.to.be.visible

  describe 'on form submit with valid data', ->

    beforeEach ->
      sinon.stub( namePicker, 'emit' )
      namePicker.show()
      namePicker.$nameInput.val( 'bucket' )
      namePicker.$nameForm.submit()

    afterEach ->
      namePicker.emit.restore()

    it 'emits a done event with the chosen name', ->
      expect( namePicker.emit ).to.have.been.calledWith( 'done', 'bucket' )

    it 'hides itself', ->
      expect( namePicker.$el ).not.to.be.visible

  describe 'on form submit with invalid data', ->

    beforeEach ->
      sinon.stub( namePicker, 'emit' )
      namePicker.show()
      namePicker.$nameInput.val( '' )
      namePicker.$nameForm.submit()

    afterEach ->
      namePicker.emit.restore()

    it 'will not emit a done event', ->
      expect( namePicker.emit ).not.to.have.been.called

    it 'will alert the user to input a non-blank name', ->
      expect( namePicker.$error ).to.be.visible

    it 'will still be visible', ->
      expect( namePicker.$el ).to.be.visible

