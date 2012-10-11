# It's the main class for the application's widget
( ($) ->
	klass = (options) ->
		options = $.extend {}, klass.options, options
		_create: ->
			_parseEvents()
			_parseNodes()

		_parseNodes: ->
			attr = 'data-attach-node'
			iterator = (node) ->
				$(@)[$.attr(node, attr)] = node
			_parse(attr, iterator)

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
			_parse(attr, iterator)

		_parse: (attr, iterator) ->
			for node in $(@element).find("[#{attr}]")
				do(node) ->
					iterator(node)
					$.removeAttr(node, attr)
		
	$.widget "tm.ui.Base", klass
) jQuery
