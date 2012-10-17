class Project extends tm._Templated

	tasks: []

	initSubwidgets: ->
		@_initTasks()

	_initTasks: ->
		wNodes = $(@options.dom).find('[data-attach-widget="tm.Task"]')
		@tasks = (@createTask(node) for node in wNodes)

	createTask: (dom) ->
		new tm.Task {dialog: @options.dialog, attachNode: @tasksContainer}, dom
			

	onEdit: (target) ->
		@options.dialog.open target, {title: 'Edit project'}, @onSave

	onSave: (data = {}) =>
		@applyToDOM(data)

	onDelete: (target) ->
		@options.dialog.confirm(target, null, => @destroy())

	destroy: ->
		task.destroy() for task in @tasks
		super

namespace 'tm', (exports) ->
	exports.Project = Project
