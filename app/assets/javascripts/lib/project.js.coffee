klass = 
	options: 
		template: 'templates/project'
	tasks: []

	_create: ->
		@._createTasks()

	_createTasks: ->
		#@tasks = (new $.tm.Task({data: data}) for data in @options.data.tasks)

$.widget "tm.Project", $.tm._Templated, klass
