class Tooltip
	
	@open: (opener, context) ->
		t = $(context).find('.tooltip')
		t.blur ->
			debugger
			tm.Tooltip.close(@)
		t.css($(opener).position())
		t.focus

	@close: (tooltip) ->
		console.log('close')
		$(tooltip).css
			top: -999
			left: -999

namespace 'tm', (exports) ->
	exports.Tooltip = Tooltip
