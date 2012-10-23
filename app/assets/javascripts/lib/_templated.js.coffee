class _Templated
	mainContainer: '#page'

	dataAttrs:
		widget: 'data-attach-widget'
		point: 'data-attach-point'
		event: 'data-attach-event'
		name: 'data-name'

	initSubwidgets: ->
		# could be redefined in children classes

	constructor: (@element, args = {}) ->
		@dialog = new tm.FormDialog()
		@ajax = tm.Ajax
		@initSubwidgets()
		@_parseEvents()
		@_parseNodes()
		$.extend(@, args)

	_parseNodes: ->
		@options = {attachPoints: {}}
		iterator = (node) ->
			attr = $.attr(node, @dataAttrs.point)
			@options.attachPoints[attr] = node
		@_parse(@dataAttrs.point, iterator)

	_parseEvents: ->
		iterator = (node) ->
			pairs = $.attr(node, @dataAttrs.event).split(',')
			for pair in pairs
				do(pair) =>
					_pair = pair.split(':')
					event = $.trim(_pair[0])
					handler = $.trim(_pair[1])
					$(node)[event] =>
						@[handler](node)
		@_parse(@dataAttrs.event, iterator)

	_parse: (attr, iterator) ->
		for node in $(@element).find("[#{attr}]")
			do(node) =>
				iterator.call(@, node)
				$.removeAttr(node, attr)

	applyToDOM: (data) ->
		for k,v of @options.attachPoints
			$(v).text(data[k]) if data[k]

	onDelete: (opener) ->
		return if !opener
		content = 'Are you sure you want to delete item?'
		callback = (response) => @destroy()
		@dialog.openConfirm(opener, {title: "Delete item"}, content, callback)

	destroy: ->
		$(@element).remove()

namespace 'tm', (exports) ->
	exports._Templated = _Templated
