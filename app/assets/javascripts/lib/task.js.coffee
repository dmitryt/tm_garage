class Task extends tm._Templated

	onEdit: (target) ->
		@options.dialog.open target, {title: 'Edit task'}, @onSave

	onSave: (data = {}) =>
		@applyToDOM(data)

	onDelete: (target) ->
		@options.dialog.confirm(target, null, => @destroy())

	onChangePriority: ->
		console.log('onChangePriority')

namespace 'tm', (exports) ->
	exports.Task = Task
