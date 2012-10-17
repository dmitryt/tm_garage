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

	getAuthData: ->
		data = {}
		csrf_token = $('meta[name=csrf-token]').attr('content')
		csrf_param = $('meta[name=csrf-param]').attr('content')
		data[csrf_param] = csrf_token
		data

	init: ->
		@dOptions.buttons = 
			"save": => @_onSave()
			"cancel": => @close()
		@_apply @dOptions

	setForm: (@form) ->
		@reset()
		@form.submit -> false
		@dialog.append(@form)

	setContent: (content) ->
		@reset()
		@dialog.append(content)

	confirm: (opener, content = 'Are you sure you want to delete item?', @onSave = ->) ->
		args =
			buttons:
				"ok": => @_onSave()
				"cancel": => @close()
			title: 'Delete item'
		@_apply $.extend({}, @dOptions, args)
		@setContent content
		@ajaxArgs = 
			url: $(opener).attr('data-url')
			type: $(opener).attr('data-method') || 'post'
			data: @getAuthData()
		@type = 'confirm'
		@_apply 'open'
	
	open: (opener, options = {}, @onSave = ->) ->
		return if !opener
		df = $.ajax
			url: $(opener).attr('data-url')
		df.done (form) =>
			@_apply $.extend({}, @dOptions, options)
			@setForm $(form)
			@type = 'form'
			@_apply 'open'

	reset: ->
		@dialog.empty()
		delete @type

	close: ->
		@_apply 'close'

	onSave: ->

	_onSave: ->
		btns = $(@dialog.get(0).parentNode).find('button')
		btns.attr('disabled', 'disabled')
		df = $.ajax(@_getAjaxArgs())
		df.done (response) =>
			@onSave(response)
			@close()
		df.always -> btns.removeAttr('disabled')

	# external method, is used for generating args from form
	getAjaxArgs: (form) ->
		@reset()
		@_getAjaxArgs form

	_getAjaxArgs: (form) ->
		f = form || @form
		return @ajaxArgs if @type == 'confirm'
		args = 
			url: f.attr('action')
			type: f.attr('method')
			data: f.serialize()	

	_apply: (something) ->
		@dialog.dialog(something)

namespace 'tm', (exports) ->
	exports.FormDialog = FormDialog
