class Dialog
	
	@_instance: undefined

	dOptions:
		modal: true
		resizable: false
		draggable: false
		autoOpen: false

	buttons:
		ok:
			title: "ok"
			callback: => onOk
		cancel:
			title: "cancel"
			callback: => onCancel

	constructor: (args) ->
		return Dialog._instance if Dialog._instance
		@dom = $('#dialog')
		Dialog._instance = @

	setContent: (content) ->
		@reset()
		@dom.append(content)

	reset: ->
		@dom.empty()

	open: (options = {}, content = '') ->
		@setContent(content)
		@setOptions(options)
		@_apply 'open'

	close: ->
		@_apply 'close'

	setOptions: (options = {}) ->
		buttons = {}
		for k,v of $.extend({}, @buttons, options.buttons)
			buttons[v.title] -> v.callback
		delete options.buttons
		@_apply 'option', $.extend({}, @dOptions, buttons, options)

	_apply: (command, args = {}) ->
		@dom.dialog command, args

	#Handlers
		onOk: ->
		onCancel: ->
			@close()

namespace 'tm', (exports) ->
	exports.Dialog = Dialog
