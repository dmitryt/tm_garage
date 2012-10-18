class FormDialog extends tm.Dialog

	@_instance: undefined

	buttons:
		ok: 'save'
		cancel: 'cancel'

	constructor: (args) ->
		return FormDialog._instance if FormDialog._instance
		super
		FormDialog._instance = @

	setForm: (@form) ->
		@form.submit -> false
		@setContent(@form)

	confirm: (opener, content = 'Are you sure you want to delete item?', @onSave = ->) ->
		args =
			buttons:
				"ok": "save"
				"cancel": "cancel"
			title: 'Delete item'
		@_apply $.extend({}, @dOptions, args)
		@setContent content
		@ajaxArgs = 
			url: $(opener).attr('data-url')
			type: $(opener).attr('data-method') || 'post'
			data: @getAuthData()
		@type = 'confirm'
		@_apply 'open'

	openForm: (opener, options = {}) ->
		return if !opener
		df = $.ajax
			url: $(opener).attr('data-url')
		df.done (form) =>
			@setForm $(form)
			@_open(options)

	openConfirm: (options, content) ->
		options.buttons ?= {ok: 'ok'}
		@setContent content
		@_open(options)

	onAccept: (callback = -> )->
		@disable true
		df = $.ajax
			
		df.done (response) =>
			err = response.errors
			if (err.length != 0) 
				return @showErrors(err)
			callback response.data
			@close()
		df.always => @disable(false)

	getAjaxArgs: ->
		
		url: @form.attr('action')
		type: @form.attr('method')
		data: @form.serialize()

	disable: (flag) ->
		debugger
		return if !@form
		btns = $(@dom.get(0).parentNode).find('button')
		if flag
			btns.attr('disabled', 'disabled')
		else
			btns.removeAttr('disabled')

	showErrors: (errors = []) ->
		v = errors.join('<br/>')
		@form.find('.errors').html v

namespace 'tm', (exports) ->
	exports.FormDialog = FormDialog
