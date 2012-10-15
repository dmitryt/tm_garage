class FormDialog extends tm._Templated

	dOptions:
		modal: true
		resizable: false
		draggable: false
		autoOpen: false

	constructor: (@options, @element) ->
		@dialog = $('#dialog')
		super
		@init()

	init: ->
		@dOptions.buttons = 
			"save": => @onSave()
			"cancel": => @close()
		@_apply @dOptions

	setForm: (@form, data = {}) ->
		@reset()
		attr = @dataAttrs.name
		@form.find("[#{attr}]").map (i, node) ->
			v = data[$(node).attr(attr)]
			$(node).val(v)
		@dialog.append(@form)
	
	open: (args, form, data = {}, @onSave = ->) ->
		debugger
		@setForm(form, data)
		@_apply $.extend({}, @dOptions, args)
		@_apply 'open'

	reset: ->
		@dialog.empty()

	close: ->
		@_apply 'close'

	_apply: (something) ->
		@dialog.dialog(something)

namespace 'tm', (exports) ->
	exports.FormDialog = FormDialog
