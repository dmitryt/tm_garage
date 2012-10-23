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
		@tasks = (@createTask(node) for node in wNodes)

	createTask: (dom) ->
		@tasks.push(new tm.Task dom, {project: @})

	onAddTask: ->
		ap = @options.attachPoints
		form = ap.addTaskForm
		@ajax.sendForm(form).done (r) =>
			@ajax.onResponse {response: r, form: form}, =>
				node = $(r).appendTo(ap.tasksContainer)
				@createTask node
				form.get(0).reset
				@checkEmptyMessage

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

	checkEmptyMessage: ->
		m = @tasks.length ? 'hide' : 'show';
		$(@options.attachPoints.emptyContainer)[m];

namespace 'tm', (exports) ->
	exports.Project = Project
