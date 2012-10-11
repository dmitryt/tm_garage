( ($) ->
	klass = (options) ->
		options = $.extend {}, $.fn.project.options, options
	$.widget "ui.Base", klass
) jQuery
