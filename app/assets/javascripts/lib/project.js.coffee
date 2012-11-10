class Project extends tm._Templated

	constructor: ->
		@tasks = []
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
		(@createTask(node) for node in wNodes)

	createTask: (dom) ->
		new tm.Task dom, {project: @}

	reorderTask: (task, priority = task.getPriority()) ->
		# Select tasks with a same priority
		allTasks = $(@element).find('.j-task')
		tasks = allTasks.filter ->
			parseInt($(@).attr('priority')) == priority
		if (tasks.length != 0)
			$(task.element).insertAfter($(tasks).last())
		else if ($(allTasks).index(task.element) != 0)
			$(task.element).insertBefore($(allTasks).first())
		$(task.element).attr('priority', priority)

	onAddTask: ->
		ap = @options.attachPoints
		form = ap.addTaskForm
		@ajax.sendForm(form).done (r) =>
			@ajax.onResponse {response: r, form: form}, =>
				node = $(r).appendTo(ap.tasksContainer)
				form.get(0).reset()
				@reorderTask(@createTask(node))
				@itemChangeAlert('created')

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
