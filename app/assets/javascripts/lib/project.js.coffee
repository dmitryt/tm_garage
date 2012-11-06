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
		nodes = $(@tasks).map (t) =>
			t.element
		nodes = nodes.filter (i) =>
			parseInt(nodes[i].attr('priority')) == priority
		if (nodes.length != 0)
			$(task.element).insertAfter($(nodes).last())
		else if ($(@tasks).index(task) != 0)
			$(task.element).insertBefore($(@tasks).first().get(0).element)
		$(task.element).attr('priority', priority)

	onAddTask: ->
		ap = @options.attachPoints
		form = ap.addTaskForm
		@ajax.sendForm(form).done (r) =>
			@ajax.onResponse {response: r, form: form}, =>
				node = $(r).appendTo(ap.tasksContainer)
				@createTask node
				form.get(0).reset()
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
