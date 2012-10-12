# It's the main class for the application's widget
(($) -> $.widget "tm._Templated"
	options:{
		mainContainer: '#page'
	}
	_createWidget: (options, element) ->
		if !element
			element = $(JST[@options.template](options.data))
			element.appendTo(options.attachNode || @options.mainContainer)
		$.Widget.prototype._createWidget.call(@, options, element)

	_create: ->
		@._parseEvents()
		@._parseNodes()
		true

	_parseNodes: ->
		attr = 'data-attach-point'
		iterator = (node) ->
			$(@)[$.attr(node, attr)] = node
		@._parse(attr, iterator)

	_parseEvents: ->
		attr = 'data-attach-events'
		iterator = (node) ->
			pairs = $.attr(node, attr).split(',')
			for pair in pairs
				do(pair) ->
					_pair = pair.split(':')
					event = $.trim(_pair[0])
					handler = $.trim(_pair[1])
					$(node)[event] => handler
		@._parse(attr, iterator)

	_parse: (attr, iterator) ->
		for node in $(@element).find("[#{attr}]")
			do(node) ->
				iterator(node)
				$.removeAttr(node, attr)
)(jQuery)
