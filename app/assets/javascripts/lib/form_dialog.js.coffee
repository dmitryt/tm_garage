class FormDialog extends tm.Dialog

	@_instance: undefined

	buttons:
		ok: 'save'
		cancel: 'cancel'

	constructor: (args) ->
		return FormDialog._instance if FormDialog._instance
		super
		FormDialog._instance = @

	getAuthData: ->
		data = {}
		csrf_token = $('meta[name=csrf-token]').attr('content')
		csrf_param = $('meta[name=csrf-param]').attr('content')
		data[csrf_param] = csrf_token
		data

	setForm: (@form) ->
		@form.submit -> false
		@setContent(@form)

	openForm: (opener, options = {}, callback = ->) ->
		return if !opener
		df = $.ajax
			url: $(opener).attr('data-url')
		df.done (form) =>
			@setForm $(form)
			@_open(options).done =>
				@_sendForm().done (response) => 
					@onResponse(response, callback)

	openConfirm: (opener, options = {}, content = '', callback = ->) ->
		options.buttons ?= {ok: 'ok'}
		@setContent content
		@_open(options).done =>
			@close()
			@_sendRequest(opener).done (response) => 	
				@onResponse(response, callback)

	_sendForm: ->
		@disable true
		df = $.ajax
			url: @form.attr('action')
			type: @form.attr('method')
			data: @form.serialize()
		df.fail => @onFailure()
		df.always => @disable(false)
		df

	_sendRequest: (opener) ->
		df = $.ajax
			url: $(opener).attr('data-url')
			type: $(opener).attr('data-method') || 'post'
			data: @getAuthData()
		df.fail => @onFailure()

	onResponse: (response, callback = ->) ->
		# Is used only for showing errors, if it's needed
		err = response.errors
		if (err && err.length != 0) 
			return @showErrors(err)
		callback(response.data || response)
		@close()

	onFailure: ->
		alert('Something went wrong')

	disable: (flag) ->
		return if !@form
		btns = $(@dom.get(0).parentNode).find('button')
		if flag
			btns.attr('disabled', 'disabled')
		else
			btns.removeAttr('disabled')

	showErrors: (errors = []) ->
		delimiter = @form ? '<br/>' : '\n'
		v = errors.join(delimiter)
		return alert(v) if !@form
		@form.find('.errors').html v

namespace 'tm', (exports) ->
	exports.FormDialog = FormDialog
