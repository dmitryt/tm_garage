class FormDialog extends tm._Templated

	dOptions:
		modal: true
		resizable: false
		draggable: false
		autoOpen: false

	constructor: (@options, @element = $('#dialog'), @engine) ->
		super(@options, @element, @engine)
		@init()

	init: ->
		@dOptions.buttons = 
			"save": => @onSave()
			"cancel": => @close()
		@_apply @dOptions
	
	open: (args, form) ->
		@_apply $.extend({}, @dOptions, args)
		@_apply 'open'

	close: ->
		@_apply 'close'

	_apply: (something) ->
		$(@element).dialog(something)

	onSave: -> 
		console.log('onSave')

namespace 'tm', (exports) ->
	exports.FormDialog = FormDialog
