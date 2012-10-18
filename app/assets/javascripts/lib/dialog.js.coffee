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

	_open: (options = {}) ->
		@setOptions(options)
		@_apply 'open'

	close: ->
		@_apply 'close'

	setOptions: (options = {}) ->
		buttons = {}
		_buttons = $.extend({}, @buttons, options.buttons)
		callback = options.callback
		buttons[_buttons.ok] = => @onAccept(callback)
		buttons[_buttons.cancel] = => @onCancel()
		delete options.callback
		delete options.buttons
		@_apply $.extend({}, @dOptions, {buttons: buttons}, options)

	_apply: (something) ->
		@dom.dialog(something)

	onAccept: (callback = ->) ->
		callback()

	onCancel: ->
		@close()
		

namespace 'tm', (exports) ->
	exports.Dialog = Dialog
