class Project extends tm._Templated

	constructor: ->
		super
		@_initAddTaskForm()

	initSubwidgets: ->
		@_initTasks()

	_initAddTaskForm: ->
		@options.attachPoints.addTaskForm = $(@element).find('form.new_task')
		@options.attachPoints.addTaskForm.submit => 
			@onAddTask()
			false

	_initTasks: ->
		wNodes = $(@element).find('[data-attach-widget="tm.Task"]')
		@createTask(node) for node in wNodes

	createTask: (dom) ->
		new tm.Task {dialog: @options.dialog}, dom

	onAddTask: ->
		ap = @options.attachPoints
		args = @options.dialog.getAjaxArgs(ap.addTaskForm)
		df = $.ajax args
		df.done (r) =>
			node = $(r).appendTo(ap.tasksContainer)
			@createTask node
			ap.addTaskForm.get(0).reset()

	onEdit: (target) ->
		@options.dialog.open target, {title: 'Edit project'}, @onSave

	onSave: (data = {}) =>
		@applyToDOM(data)

	onDelete: (target) ->
		@options.dialog.confirm(target, null, => @destroy())

namespace 'tm', (exports) ->
	exports.Project = Project
