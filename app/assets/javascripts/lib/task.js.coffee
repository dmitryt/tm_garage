class Task extends tm._Templated

	constructor: ->
		super
		@tooltip = new tm.Tooltip()

	onEdit: (target) ->
		args = 
			title: 'Edit task'
		formOnLoad = @dialog.openForm target, args, (r) => @onSave(r)
		formOnLoad.done ->
			$('#task_deadline_at').datepicker({minDate: 0})

	onSave: (data = {}) =>
		@applyToDOM(data)
		@itemChangeAlert('updated')

	onChangePriority: (opener) ->
		@tooltip.open opener, @

	onChanged: (pValue) ->
		form = @getForm()
		$(form.get(0)['task[priority_id]']).val pValue
		@ajax.sendForm(form).done (r) =>
			@ajax.onResponse {response: r, form: form}, (data) =>
				$(@element).find('.b-row').css('background-color', data.priority.color);
				@project.reorderTask(@, data.priority.id)
				@itemChangeAlert('updated')

	getForm: ->
		$(@element).find('form')	

	_send: ->
		
	onFinish: ->
		form = @getForm()
		@ajax.sendForm(form).done (r) =>
			@ajax.onResponse {response: r, form: form}, =>
				m = if r.data.finished then 'addClass' else 'removeClass'
				$(@element)[m]('h-finished')
				@itemChangeAlert('updated')

namespace 'tm', (exports) ->
	exports.Task = Task
