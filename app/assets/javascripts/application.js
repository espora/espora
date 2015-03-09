// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-ui
//= require jquery_nested_form
//= require_tree .


/**
 *loadPanel:
 *   Hace una peticion via ajax a una url dada
 *   y el resultado lo pone en el panel dado
 */
function loadPanel( url, panel ) {

	// Pedimos via ajax
	$.ajax({
		type: "GET",
		url: url,
		dataType: "html",
		success: function( data ) {
			panel.html( data );
		}
	});

}

function timerAlertBox (elem) {
	setTimeout(function() {
		$(elem).remove();
	}, 4000);
}
