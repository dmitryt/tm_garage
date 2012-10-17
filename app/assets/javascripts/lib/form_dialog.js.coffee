class FormDialog extends tm.Dialog

	setForm: (@form) ->
		@reset()
		@form.submit -> false
		@setContent(@form)

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

namespace 'tm', (exports) ->
	exports.FormDialog = FormDialog
