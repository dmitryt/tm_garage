class Manager
	projects: []

	constructor: (projects) ->
		@_initProjects(projects)

	_initProjects: (projects = []) ->
		@projects = (new $.tm.Project({data: data}) for data in projects)

namespace 'tm', (exports) ->
	exports.Manager = Manager
