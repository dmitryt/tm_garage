class Task extends tm._Templated
	options: 
		template: 'task'
		form: '#taskForm'

	constructor: (options) ->
		Task.form ?= $($(@options.form).html())
		super(options)

	onEdit: ->
		@options.dialog.open
			title: 'Edit task'
			Task.form 
			@options.data
			@onSave

	onSave: ->
		console.log('onSave task')

	onDelete: ->
		console.log('onDelete')

	onChangePriority: ->
		console.log('onChangePriority')

namespace 'tm', (exports) ->
	exports.Task = Task
