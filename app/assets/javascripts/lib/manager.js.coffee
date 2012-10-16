class Manager
	projects: []

	constructor: (projects) ->
		@_initDialog()
		@_initProjects(projects)
		@_setEventListeners()

	_initDialog: ->
		@dialog = new tm.FormDialog({})

	_initProjects: (projects = []) ->
		@projects = (@createProject({data: data}) for data in projects)

	_setEventListeners: ->
		btn = $('#addProjectBtn')
		btn.click => @openAddPopup(btn.attr('data-url'))
	
	createProject: (args = {}) ->
		new tm.Project($.extend({dialog: @dialog}, args))
	
	openAddPopup: (url) ->
		df = $.ajax
			url: url
		df.done (form) =>
			@dialog.open({title: 'Add project'}, $(form), @onAddProject)

	onAddProject: (form) ->
		df = $.ajax
			url: form.attr('action')
			type: 'post'
			dataType: 'json'
			data: form.serialize()
		df.done (response) =>
			r = JSON.parse(response)
			@createProject({data: r.data, template: r.template})
			

namespace 'tm', (exports) ->
	exports.Manager = Manager
