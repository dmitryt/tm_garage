class Tooltip

	@_instance: null,

	opened: false,

	context: null,

	constructor: ->
		return tm.Tooltip._instance if tm.Tooltip._instance
		@element = $('#tooltip')
		@element.click (e) => e.stopPropagation()
		$(document.body).click => @close()
		$(@element).find('input[type="radio"]').change => @onChange()
		tm.Tooltip._instance = @
	
	open: (opener, @context) ->
		@close()
		@element.css($(opener).offset())
		@element.trigger 'focus'
		cb = => @opened = true
		setTimeout cb, 0
		@_getRadioBtns("[value=\"#{@context.getPriority()}\"]").attr('checked', 'checked')

	onChange: ->
		@context.onChanged(@_getRadioBtns(':checked').val())
		@close()

	_getRadioBtns: (criteria) ->
		$(@element).find("input[type='radio']#{criteria}")

	close:  ->
		return if !@opened
		$(@element).css
			top: -999
			left: -999
		@opened = false
		

namespace 'tm', (exports) ->
	exports.Tooltip = Tooltip
