class Task extends tm._Templated
	options: 
		template: 'templates/task'

	onEdit: ->
		console.log('onEdit')

	onDelete: ->
		console.log('onDelete')

	onChangePriority: ->
		console.log('onChangePriority')

namespace 'tm', (exports) ->
	exports.Task = Task
