class Project extends tm._Templated

	options: 
		template: 'project'
		form: '#projectForm'
		data: {}

	@url: '/projects'

	tasks: []

	constructor: (options) ->
		Project.form ?= $($(@options.form).html())
		super(options)

	initSubwidgets: ->
		@_initTasks() if !@isNew()

	_initTasks: ->
		@tasks = @options.data.tasks.map (data) =>
			@_renderTask data

	_renderTask: (data) ->
		new tm.Task
			data: data
			attachNode: @tasksContainer
			dialog: @options.dialog

	onEdit: ->
		@options.dialog.open
			title: 'Edit project'
			Project.form 
			@options.data
			@onSave

	onSave: ->
		console.log('onSave')

	onDelete: ->
		console.log('onDelete')

	destroy: ->
		task.destroy() for task in @tasks
		super

namespace 'tm', (exports) ->
	exports.Project = Project
