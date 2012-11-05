class Manager
		
	mainContainer: '#page'

	constructor: () ->
		@_initProjects()
		@dialog = new tm.FormDialog()
		@flash = new tm.Flash()
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
			@flash.show({message: ['action', {'action': 'created'}], type: 'info'})
		@dialog.openForm opener, args, (r) => cb(r)

namespace 'tm', (exports) ->
	exports.Manager = Manager
