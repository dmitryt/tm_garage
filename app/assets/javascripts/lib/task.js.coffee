class Task extends tm._Templated

	constructor: ->
		super
		@tooltip = new tm.Tooltip()

	onEdit: (target) ->
		args = 
			title: 'Edit task'
		@dialog.openForm target, args, (r) => @onSave(r)

	onSave: (data = {}) =>
		@applyToDOM(data)

	onChangePriority: (opener) ->
		@tooltip.open opener, @

	onChanged: (pValue) ->
		form = @getForm
		$(form.priority_id).val pValue
		@ajax.sendForm(form).done (r) =>
			@ajax.onResponse {response: r, form: form}, =>


	getForm: ->
		$(@element).find('form')	

	_send: ->
		
	onFinish: ->
		form = @getForm
		@ajax.sendForm(form).done (r) =>
			@ajax.onResponse {response: r, form: form}, =>
				m = if r.data.finished then 'addClass' else 'removeClass'
				$(@element)[m]('h-finished')

namespace 'tm', (exports) ->
	exports.Task = Task
