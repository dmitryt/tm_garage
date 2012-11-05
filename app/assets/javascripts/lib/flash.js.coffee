class Flash

	@_instance: undefined

	messages:
		action: 'Item was ${action} successfully'

	typeMap:
		default: 'ui-notify-default'
		info: 'ui-notify-info'
		error: 'ui-notify-error'

	constructor: (args) ->
		return Flash._instance if Flash._instance
		Flash._instance = @
		@container = $('#notification').notify()

	show: (args = {}) ->
		_evts = {
            beforeopen: (e, instance) =>
            	$(e.target).addClass(@typeMap[args.type || 'default'])
			click: (e, instance) =>
				instance.close()
		}
		@container.notify('create', 0, {text: @_getText(args.message)}, _evts)

	_getText: (message = '') ->
		return message unless $.isArray(message)
		text = @messages[message[0]]
		data = message[1]
		for k, v of data
			text = text.replace(new RegExp("\\\${#{k}}", 'g'), v)
		text

namespace 'tm', (exports) ->
	exports.Flash = Flash
