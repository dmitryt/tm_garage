class Task extends tm._Templated

	constructor: ->
		super
		@tooltip = tm.Tooltip

	onEdit: (target) ->
		args = 
			title: 'Edit task'
		@dialog.openForm target, args, (r) => @onSave(r)

	onSave: (data = {}) =>
		@applyToDOM(data)

	onChangePriority: (opener) ->
		@tooltip.open opener, @element

	onFinish: ->
		form = $(@element).find('form')
		@ajax.sendForm(form).done (r) =>
			@ajax.onResponse {response: r, form: form}, =>
				m = if r.data.finished then 'addClass' else 'removeClass'
				$(@element)[m]('h-finished')

namespace 'tm', (exports) ->
	exports.Task = Task
