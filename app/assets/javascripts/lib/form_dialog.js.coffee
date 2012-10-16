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
			"save": => @_onSave()
			"cancel": => @close()
		@_apply @dOptions

	setForm: (@form) ->
		@reset()
		@form.submit -> false
		@dialog.append(@form)
	
	open: (opener, options = {}, @onSave = =>) ->
		return if !opener
		df = $.ajax
			url: $(opener).attr('data-url')
		df.done (form) =>
			@_apply $.extend({}, @dOptions, options)
			@setForm $(form)
			@_apply 'open'

	reset: ->
		@dialog.empty()

	close: ->
		@_apply 'close'

	onSave: ->

	_onSave: ->
		btns = $(@dialog.get(0).parentNode).find('button')
		btns.attr('disabled', 'disabled')
		debugger
		df = $.ajax
			url: @form.attr('action')
			type: @form.attr('method')
			data: @form.serialize()
		df.done (response) =>
			@onSave(response)
			@close()
		df.always -> btns.removeAttr('disabled')
			

	_apply: (something) ->
		@dialog.dialog(something)

namespace 'tm', (exports) ->
	exports.FormDialog = FormDialog
