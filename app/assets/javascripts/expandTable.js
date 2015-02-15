(function($) {
	$.fn.expandTable = function() {
		var element = this;

		$(element).find("tr:odd").addClass("odd");
		$(element).find("tr:not(.odd)").hide();
		$(element).find("tr:first-child").show();

		$(element).find("tr.odd").click(function() {
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