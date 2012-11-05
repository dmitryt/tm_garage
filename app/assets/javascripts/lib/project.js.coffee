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
		@tasks.push(new tm.Task dom, {project: @})

	reorderTask: (task, priority) ->
		# Select tasks with a same priority
		tasks = $(@tasks).filter (i) ->
			parseInt($(@element).attr('priority')) == priority
		if (tasks.length != 0)
			$(task.element).insertAfter(tasks.last().get(0).element)
		else
			$(task.element).insertBefore($(@tasks).first().get(0).element)
		$(task.element).attr('priority', priority);

	onAddTask: ->
		ap = @options.attachPoints
		form = ap.addTaskForm
		@ajax.sendForm(form).done (r) =>
			@ajax.onResponse {response: r, form: form}, =>
				node = $(r).appendTo(ap.tasksContainer)
				@createTask node
				form.get(0).reset
				@checkEmptyMessage
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

	checkEmptyMessage: ->
		m = @tasks.length ? 'hide' : 'show';
		$(@options.attachPoints.emptyContainer)[m];

namespace 'tm', (exports) ->
	exports.Project = Project
