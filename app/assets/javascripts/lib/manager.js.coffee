class Manager
		
	mainContainer: '#page'

	constructor: () ->
		@_initDialog()
		@_initProjects()
		@_setEventListeners()

	_initDialog: ->
		@dialog = new tm.FormDialog({})

	_initProjects: (projects = []) ->
		wNodes = $('[data-attach-widget="tm.Project"]')
		@projects = (@createProject(node) for node in wNodes)

	_setEventListeners: ->
		btn = $('#addProjectBtn')
		btn.click => @openPopup(btn, {title: 'Add project'})
	
	createProject: (dom) ->
		new tm.Project {dialog: @dialog}, dom

	openPopup: (opener = null, args) ->
		@dialog.open opener, args, @onAddProject

	onAddProject: (r) =>
		node = $(r).appendTo(@mainContainer)
		@createProject node
			

namespace 'tm', (exports) ->
	exports.Manager = Manager
