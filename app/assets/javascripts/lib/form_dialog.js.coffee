class FormDialog extends tm._Templated

	dOptions:
		modal: true
		resizable: false
		draggable: false
		autoOpen: false

	constructor: (@options, @element) ->
		@dialog = $('#dialog')
		@saveBtn = 
		super
		@init()

	init: ->
		@dOptions.buttons = 
			"save": => @_onSave()
			"cancel": => @close()
		@_apply @dOptions

	setForm: (@form, data = {}) ->
		@reset()
		@form.submit -> false
		@dialog.append(@form)
	
	open: (args, form, @onSave = ->) ->
		@setForm(form)
		@_apply $.extend({}, @dOptions, args)
		@_apply 'open'

	reset: ->
		@dialog.empty()

	close: ->
		@_apply 'close'

	_onSave: ->
		btns = $(@dialog.get(0).parentNode).find('button')
		btns.attr('disabled', 'disabled')
		df = @onSave(@form)
		df.always -> btns.removeAttr('disabled')
			

	_apply: (something) ->
		@dialog.dialog(something)

namespace 'tm', (exports) ->
	exports.FormDialog = FormDialog
