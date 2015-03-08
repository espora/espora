(function($) {
	$.fn.expandTable = function(options) {

		var element = this;
		var tableBody = $(this).find("> tbody")[0];
		var onExandFunc = options.beforeExpand;

		$(tableBody).find("> tr:even").addClass("even");
		$(tableBody).find("> tr:not(.even)").hide();

		$(tableBody).find("> tr.even").click(function() {
			onExandFunc($(this).next("tr"));

			$(this).next("tr").toggle();

			var icon = $(this).find(".arrow-expand i");
			if(icon.length > 0) {
				if(icon.hasClass("fa-caret-down")) {
					icon.removeClass("fa-caret-down");
					icon.addClass("fa-caret-up");
				} else {
					icon.removeClass("fa-caret-up");
					icon.addClass("fa-caret-down");
				}
			}
		});
	}
})(jQuery);