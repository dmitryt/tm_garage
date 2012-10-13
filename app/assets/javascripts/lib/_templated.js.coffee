class _Templated
	mainContainer: '#page'

	constructor: (options = {}, @element, @engine = JST) ->
		@options = $.extend {}, @options, options
		if !@element
			@element = $(@engine[@options.template](@options.data))
		@element.appendTo(@options.attachNode || @mainContainer)
		@_parseEvents()
		@_parseNodes()

	_parseNodes: ->
		attr = 'data-attach-point'
		iterator = (node) ->
			@[$.attr(node, attr)] = node
		@_parse(attr, iterator)

	_parseEvents: ->
		attr = 'data-attach-event'
		iterator = (node) ->
			pairs = $.attr(node, attr).split(',')
			for pair in pairs
				do(pair) =>
					_pair = pair.split(':')
					event = $.trim(_pair[0])
					handler = $.trim(_pair[1])
					$(node)[event] =>
						@[handler]()
		@_parse(attr, iterator)

	_parse: (attr, iterator) ->
		for node in $(@element).find("[#{attr}]")
			do(node) =>
				iterator.call(@, node)
				$.removeAttr(node, attr)

	destroy: ->
		$(@element).remove

namespace 'tm', (exports) ->
	exports._Templated = _Templated
