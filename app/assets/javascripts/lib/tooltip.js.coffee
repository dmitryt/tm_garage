class Tooltip

	@_instance: null,

	opened: false,

	context: null,

	constructor: ->
		return tm.Tooltip._instance if tm.Tooltip._instance
		@element = $('#tooltip')
		@element.click (e) => e.stopPropagation()
		$(document.body).click => @close()
		$(@element).find('radio').click => @onChange()
		tm.Tooltip._instance = @
	
	open: (opener, @context) ->
		@element.css($(opener).offset())
		@element.trigger 'focus'
		cb = => @opened = true
		setTimeout cb, 0

	close:  ->
		return if !@opened
		$(@element).css
			top: -999
			left: -999
		@opened = false
		v = $(@element).find('[name=task_priority]:checked').val
		@context.onChanged v

namespace 'tm', (exports) ->
	exports.Tooltip = Tooltip
