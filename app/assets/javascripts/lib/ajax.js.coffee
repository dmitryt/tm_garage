class Ajax

	@getAuthData: ->
		data = {}
		csrf_token = $('meta[name=csrf-token]').attr('content')
		csrf_param = $('meta[name=csrf-param]').attr('content')
		data[csrf_param] = csrf_token
		data

	@sendForm: (form) ->
		df = $.ajax
			url: form.attr('action')
			type: form.attr('method')
			data: form.serialize()
		df.fail => tm.Ajax.onFailure()
		df

	@sendRequest: (opener) ->
		df = $.ajax
			url: $(opener).attr('data-url')
			type: $(opener).attr('data-method') || 'post'
			data: tm.Ajax.getAuthData()
		df.fail => tm.Ajax.onFailure()
		df

	@fetchForm: (opener) ->
		df = $.ajax
			url: $(opener).attr('data-url')
		df.fail => tm.Ajax.onFailure()
		df

	@onFailure: ->
		alert('Something went wrong')

	@onResponse: (args = {}, callback = ->) ->
		# Is used only for showing errors, if it's needed
		err = args.response.errors
		if (err && err.length != 0)
			tm.Ajax.showErrors(err, args.form)
			return false;
		callback(args.response.data || args.response)
		true

	@showErrors: (errors = [], form) ->
		delimiter = if form then '<br/>' else '\n'
		v = errors.join(delimiter)
		return alert(v) if !form
		form.find('.errors').html v

namespace 'tm', (exports) ->
	exports.Ajax = Ajax
