(function($) {

	/**
	 * ExpandTable [JQuery Plugin]
	 *
	 * Hace expandible y contraible los renglones
	 * par de una tabla.
	 *
	 * @param {Object} config - Configuración del plugin.
	 *    @param {Function} config.beforeExpand - Se llama antes de expandir o contraer
	 *    @param {Function} config.afterExpand - Se llama despues de expandir o contraers
	 */
	$.fn.expandTable = function(config) {

		// Obtenemos el cuerpo de la tabla
		var tableBody = $(this).find("> tbody")[0];

		// Guardamos los eventos
		var beforeExpand = config.beforeExpand;
		var afterExpand = config.afterExpand;

		// Clasificamos los impares
		$(tableBody).find("> tr:even").addClass("even");

		// Ocultamos los pares (los que se van a expandir)
		$(tableBody).find("> tr:not(.even)").hide();

		// Asignamos el click para expandir y contraer
		$(tableBody).find("> tr.even").click(function() {

			// Llamamos a la funcion antes
			beforeExpand(this);

			// Ocultamos o mostramos con Jquery
			$(this).next("tr").toggle();

			// Llamamos a la funcion desues
			afterExpand(this);
		});
	}
})(jQuery);