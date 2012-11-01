class FormDialog extends tm.Dialog

	@_instance: undefined

	buttons:
		ok: 'save'
		cancel: 'cancel'

	constructor: (args) ->
		return FormDialog._instance if FormDialog._instance
		super
		FormDialog._instance = @
		@ajax = tm.Ajax

	setForm: (@form) ->
		@form.submit -> false
		@setContent(@form)

	openForm: (opener, options = {}, callback = ->) ->
		return if !opener
		df = new $.Deferred()
		_df = @ajax.fetchForm(opener)
		_df.done (form) =>
			@setForm $(form)
			@_open options, onclickCb
			df.resolve()
		onclickCb = =>
			@ajax.sendForm(@form).done (response) => 
				@onResponse response, callback
		df

	openConfirm: (opener, options = {}, content = '', callback = ->) ->
		@form = null
		options.buttons ?= {ok: 'ok'}
		@setContent content
		onclickCb = =>
			@close()
			@ajax.sendRequest(opener).done (response) => 	
				@onResponse response, callback
		@_open options, onclickCb

	onResponse: (response, callback = ->) ->
		if (@ajax.onResponse({response: response, form: @form}, callback)) 
			@close()

	disable: (flag) ->
		return if !@form
		btns = $(@dom.get(0).parentNode).find('button')
		if flag
			btns.attr('disabled', 'disabled')
		else
			btns.removeAttr('disabled')

namespace 'tm', (exports) ->
	exports.FormDialog = FormDialog
