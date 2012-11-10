class Dialog

	dOptions:
		modal: true
		resizable: false
		draggable: false
		autoOpen: false

	buttons:
		ok: 'ok'
		cancel: 'cancel'

	constructor: (args) ->
		@dom = $('#dialog').dialog(@dOptions)

	setContent: (content) ->
		@reset()
		@dom.append(content)

	reset: ->
		@dom.empty()

	_open: (options = {}, callback = ->) ->
		@setOptions(options, callback)
		@_apply 'open'

	close: ->
		@_apply 'close'

	setOptions: (options = {}, callback = ->) ->
		buttons = {}
		_buttons = $.extend({}, @buttons, options.buttons)
		buttons[_buttons.ok] = => callback()
		buttons[_buttons.cancel] = => @close()
		delete options.buttons
		@_apply $.extend({}, @dOptions, {buttons: buttons}, options)

	_apply: (something) ->
		@dom.dialog(something)
		

namespace 'tm', (exports) ->
	exports.Dialog = Dialog
