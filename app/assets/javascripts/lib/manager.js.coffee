class Manager
	projects: []

	constructor: (projects) ->
		@_initDialog()
		@_initProjects(projects)

	_initDialog: ->
		@dialog = new tm.FormDialog({})

	_initProjects: (projects = []) ->
		@projects = (new tm.Project({data: data, dialog: @dialog}) for data in projects)

namespace 'tm', (exports) ->
	exports.Manager = Manager
