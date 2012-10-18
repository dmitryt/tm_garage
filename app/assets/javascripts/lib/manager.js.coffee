class Manager
		
	mainContainer: '#page'

	constructor: () ->
		@_initProjects()
		@dialog = new tm.FormDialog()
		@_setEventListeners()

	_initProjects: (projects = []) ->
		wNodes = $('[data-attach-widget="tm.Project"]')
		@projects = (@createProject(node) for node in wNodes)

	_setEventListeners: ->
		btn = $('#addProjectBtn')
		btn.click => @onAddProject(btn)
	
	createProject: (dom) ->
		new tm.Project dom

	onAddProject: (opener) ->
		args = 
			title: 'Add project'
			callback: => @_onAddProject()
		@dialog.openForm opener, args

	_onAddProject: (r) =>
		node = $(r).appendTo(@mainContainer)
		@createProject node
			

namespace 'tm', (exports) ->
	exports.Manager = Manager
