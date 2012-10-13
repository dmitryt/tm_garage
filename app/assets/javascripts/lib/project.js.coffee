class Project extends tm._Templated

	options: 
		template: 'templates/project'

	tasks: []

	constructor: ->
		super
		@_createTasks()

	_createTasks: ->
		@tasks = @options.data.tasks.map (data) =>
			@_renderTask data

	_renderTask: (data) ->
		new tm.Task
			data: data
			attachNode: @tasksContainer
			dialog: @dialog

	onEdit: ->
		@options.dialog.open({title: 'Edit project'})

	onDelete: ->
		console.log('onDelete')

	destroy: ->
		task.destroy() for task in @tasks
		super

namespace 'tm', (exports) ->
	exports.Project = Project
