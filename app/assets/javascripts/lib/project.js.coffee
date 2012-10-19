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
		new tm.Task dom

	onAddTask: ->
		ap = @options.attachPoints
		form = ap.addTaskForm
		@ajax.sendForm(form).done (r) =>
			@ajax.onResponse {response: r, form: form}, =>
				node = $(r).appendTo(ap.tasksContainer)
				@createTask node
				form.get(0).reset()

	onEdit: (target) ->
		args = 
			title: 'Edit project'
		@dialog.openForm target, args, (r) => @onSave(r)

	onSave: (data) =>
		@applyToDOM(data)

namespace 'tm', (exports) ->
	exports.Project = Project
