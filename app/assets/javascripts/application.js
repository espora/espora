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
//= require moment
//= require_tree .

/**
 * Muestra un horario en una tabla de horarios.
 *
 * El encabezado de la tabla es:
 * Hora | Lun | Mar | Mier | Jue | Vie
 *
 * Cada celda guarda como atributo el día al que pertenece,
 * un número del 1 al 5.
 * También guarda como atributo de hora (hour), minuto (minutes),
 * siguiente hora (next-hour) y siguiente minuto (next-minutes).
 *
 * @param {DOM Element} table - La tabla.
 * @param {Object} schedule - Objeto que representa al horario.
 *   @param {Number} schedule.day - El día del horario.
 *   @param {String} schedule.beginH - La hora de inicio del horario.
 *   @param {String} schedule.endH - La hora de final del horario.
 * @param {Function} onRangeHandler - Se llama por cada celda que cae en el horario
 */
function displaySchedule (table, schedule, scheduleCell) {

	// Se obtienen los horarios del dia
	var schedulesDay = $(table).find("td[day=" + schedule.day + "]");

	// Parseamos las horas
	var beginH = [ new Date(schedule.beginH).getHours() + 6,
				   new Date(schedule.beginH).getMinutes() ];
	var endH   = [ new Date(schedule.endH).getHours() + 6,
				   new Date(schedule.endH).getMinutes() ];

	// Iteramos la celdas del día
	var onSchedule = false;
	for (var i = 0; i < schedulesDay.length; i++) {

		// Parseamos los datos (atributos) de la celda
		var hour        = parseInt($(schedulesDay[i]).attr("hour"));
		var minutes     = parseInt($(schedulesDay[i]).attr("minutes"));
		var nextHour    = parseInt($(schedulesDay[i]).attr("next-hour"));
		var nextMinutes = parseInt($(schedulesDay[i]).attr("next-minutes"));

		// Si ya estamos en el horario prendemos la bandera
		if(hour == beginH[0] && minutes == beginH[1])
			onSchedule = true;

		// Si estamos en el rango llamamos al callback
		if(onSchedule)
			scheduleCell(schedulesDay[i]);

		// Si llegamos al final del horario nos detenemos
		if(nextHour == endH[0] && nextMinutes == endH[1])
			break;
	}
}

function trimSchedulesTable (table) {

	// Iteramos las filas
	var rows = $(table).find("tbody tr");
	for (var i = 0; i < rows.length; i++) {
		var oneSelected = false;
		var cells = $(rows[i]).find("td");
		for (var j = 0; j < cells.length; j++) {
			oneSelected = oneSelected || $(cells[j]).hasClass("selected-schedule");
		}

		if(!oneSelected) {
			$(rows[i]).hide();
		}
	}
}

/**
 * Dibuja una grafica con GoogleCharts.
 * 
 * @param {Object} chartSetting - Objeto que tiene la configuración de la grafica.
 * @param {DOM Element} element - Elemento DOM donde se pone la gráfica.
 */
function displayChart (chartSetting, element) {

	// Creamos la grafica
	var chart = undefined;
	switch(chartSetting.chartType) {
		case "linechart":
			chart = new google.visualization.LineChart(element);
			break;
		case "piechart":
			chart = new google.visualization.PieChart(element);
			break;
		case "columnchart":
			chart = new google.visualization.ColumnChart(element);
			break;
		case "barchart":
			chart = new google.visualization.BarChart(element);
			break;
	}

	// La dibujamos
	var dataTable = google.visualization.arrayToDataTable(chartSetting.dataTable);
	chart.draw(dataTable, chartSetting.options);
}