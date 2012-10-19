class Task extends tm._Templated

	onEdit: (target) ->
		args = 
			title: 'Edit task'
		@dialog.openForm target, args, (r) => @onSave(r)

	onSave: (data = {}) =>
		@applyToDOM(data)

	onChangePriority: ->
		console.log('onChangePriority')

namespace 'tm', (exports) ->
	exports.Task = Task
