class Project extends tm._Templated

	tasks: [],

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
		tasks = (@createTask(node) for node in wNodes)

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

	finishTask: (task, data) ->
		if data.finished
			@finishedContainer.append(task.dom)
		else
			@moveTaskToGroup(task, data)

namespace 'tm', (exports) ->
	exports.Project = Project
