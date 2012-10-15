class _Templated
	mainContainer: '#page'

	_options: 
		template: null
		data: {}

	dataAttrs:
		widget: 'data-attach-widget'
		point: 'data-attach-point'
		event: 'data-attach-event'
		name: 'data-name'

	initSubwidgets: ->
		# could be redefined in children classes

	constructor: (options = {}, @element) ->
		@options = $.extend {}, @_options, @options, options
		@_initElement()
		@initSubwidgets()
		@_parseEvents()
		@_parseNodes()
		$(@element).removeAttr(@dataAttrs.widget)

	isNew: ->
		return !@options.data.id				

	_initElement: ->
		return true if @element
		if !@isNew()
			@element = $("[#{@dataAttrs.widget}=\"#{@constructor.name}_#{@options.data.id}\"]")
			return true
		@element = $(@options.template).appendTo(@options.attachNode || @mainContainer)

	_parseNodes: ->
		iterator = (node) ->
			@[$.attr(node, @dataAttrs.point)] = node
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
						@[handler]()
		@_parse(@dataAttrs.event, iterator)

	_parse: (attr, iterator) ->
		for node in $(@element).find("[#{attr}]")
			do(node) =>
				iterator.call(@, node)
				$.removeAttr(node, attr)

	destroy: ->
		$(@element).remove

namespace 'tm', (exports) ->
	exports._Templated = _Templated
