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
		df = @setOptions(options)
		@_apply 'open'
		df

	close: ->
		@_apply 'close'

	setOptions: (options = {}) ->
		buttons = {}
		callback = ->
		_buttons = $.extend({}, @buttons, options.buttons)
		buttons[_buttons.ok] = => callback()
		buttons[_buttons.cancel] = => @close()
		delete options.buttons
		@_apply $.extend({}, @dOptions, {buttons: buttons}, options)
		=> callback()

	_apply: (something) ->
		@dom.dialog(something)
		

namespace 'tm', (exports) ->
	exports.Dialog = Dialog
