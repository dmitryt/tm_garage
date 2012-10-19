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
		cb = (r) =>
			node = $(r).appendTo(@mainContainer)
			@createProject node	
		@dialog.openForm opener, args, (r) => cb(r)

namespace 'tm', (exports) ->
	exports.Manager = Manager
