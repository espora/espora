function initSchedulesInput ( config ) {

	// Aqui vamos a guardar los horarios
	var schedules     = [ new Array(), new Array(), new Array(), new Array(), new Array() ];
	var scheduleCells = [ new Array(), new Array(), new Array(), new Array(), new Array() ];

	// Variables activas de rango
	var activeDay = -1;
	var activeRange = undefined;

	/********* INICIALIZACION ***********/

	// Llenamos los horarios con las celdas correspondientes
	for (var day = 1; day <= 5; day++) {
		var cellsDay = $(config.table).find("td[day=" + day + "]");
		for (var i = 0; i < cellsDay.length; i++) {
			scheduleCells[day - 1].push(cellsDay[i]);
		}
		scheduleCells[day - 1].sort(cellComparator);
	}

	// Llenamos los horarios guardados
	$(config.fields).find(".fields").each(function () {

		// Obtenemos los datos
		var day = $(this).find("input:nth-child(1)").val();
		var beginH = parseHour($(this).find("input:nth-child(2)").val());
		var endH = parseHour($(this).find("input:nth-child(3)").val());

		// Obtenemos las celdas de inicio y fin
		var beginCell = getCell(day, beginH[0], beginH[1], true);
		var endCell = getCell(day, endH[0], endH[1], false);

		// Usamos el manejador de horarios
		$(beginCell).removeClass("available-schedule");
		$(beginCell).addClass("selected-schedule");

		handleRange({
			range: [beginCell, endCell],
			daySchedules: schedules[day - 1],
			dayCells: scheduleCells[day - 1],
			field: $(this)[0]
		});
		fillRange(beginCell, endCell, scheduleCells[day - 1]);
	});

	/********* INTERACCION ***********/

	// Mouse presionado sobre un horario
	$(config.table).find("td").mousedown(function () {

		// Si está disponible
		if(!$(this).hasClass("available-schedule")) {
			return;
		}

		// Si no hay un rango
		if(!activeRange) {

			// Activamos las variables de rango
			activeDay = parseInt($(this).attr("day"));
			activeRange = [this];

			// Si esta disponible
			if($(this).hasClass("available-schedule")) {

				// Lo marcamos como seleccionado
				$(this).removeClass("available-schedule");
				$(this).addClass("selected-schedule");
			}
		}
	});

	// Mouse sobre celda
	$(config.table).find("td").mouseover(function () {

		// Si se esta haciendo un horario
		if(activeRange) {

			// Si estan en el mismo dia y esta disponible
			var day = parseInt($(this).attr("day"));
			if(activeDay == day) {

				// Si esta disponible
				if($(this).hasClass("available-schedule")) {

					// Lo marcamos como seleccionado
					$(this).removeClass("available-schedule");
					$(this).addClass("selected-schedule");
				}

				// Lo agregamos al rango
				activeRange.push(this);
			}
		}
	});

	// Mouse soltado
	$(document).mouseup(function () {

		// Si estabamos creando un rango
		if(activeRange) {

			// Ordenamos el rango
			activeRange.sort(cellComparator);
			activeRange = fillRange(activeRange[0], activeRange[activeRange.length - 1], scheduleCells[activeDay - 1]);

			// Creamos el rango
			$(".add_nested_fields[data-association=" + config.associationName + "]").click();
		}
	});

	// Al agregar un horario
	$(document).on("nested:fieldAdded:" + config.associationName, function( event ) {

		// Manejamos el rango
		handleRange({
			range: activeRange,
			daySchedules: schedules[activeDay - 1],
			dayCells: scheduleCells[activeDay - 1],
			field: event.field
		});

		// Desactivamos el rango
		activeDay = -1;
		activeRange = undefined;
	});

	/********* FUNCIONES ***********/

	// Selecciona las celdas que estan entre dos
	function fillRange (begin, end, dayCells) {
		var range = [];

		// Recorremos el dia rellenando
		var onRange = false;
		for (var i = 0; i < dayCells.length; i++) {

			// Comprobamos que ya esté en el rango
			onRange = onRange || (dayCells[i] == begin);

			// Si esta en el rango
			if(onRange) {

				// Si no esta seleccionada se selecciona
				if($(dayCells[i]).hasClass("available-schedule")) {
					$(dayCells[i]).removeClass("available-schedule");
					$(dayCells[i]).addClass("selected-schedule");
				}

				// Agregamos
				range.push(dayCells[i]);

				// Comprueba si ya terminamos
				if(dayCells[i] == end) {
					break;
				}
			}
		}

		return range;
	}

	// Maneja un rango creado
	function handleRange (attr) {
		
		// Obtenemos el principio y final
		var begin = attr.range[0];
		var end = attr.range[attr.range.length - 1];

		// Obtenemos los horarios que solapados
		var overlapSchedules = getOverlapSchedules(begin, end, attr.daySchedules);

		// Si es disjunto
		if(overlapSchedules.length == 0) {

			// Creamos un horario
			var newSchedule = {
				begin: {
					hour: parseInt($(begin).attr("hour")),
					minutes: parseInt($(begin).attr("minutes")),
					cell: begin
				},
				end: {
					hour: parseInt($(end).attr("next-hour")),
					minutes: parseInt($(end).attr("next-minutes")),
					cell: end
				},
				field: attr.field,
				day: activeDay
			};

			// Ponemos la información en su lugar y agregamos
			putInfo(newSchedule, newSchedule.field);
			addSchedule(newSchedule, attr.daySchedules, attr.dayCells);
		}

		// Hubo solapados
		else {
			mergeSchedules({
				begin: begin,
				end: end,
				overlaps: overlapSchedules,
				day: activeDay,
				field: attr.field,
				daySchedules: attr.daySchedules,
				dayCells: attr.dayCells
			});
		}
	}

	// Mezcla los rangos
	function mergeSchedules (attr) {

		// Creamos el horario unión
		var unionSchedule = {
			begin: undefined,
			end: undefined,
			field: attr.field,
			day: attr.day
		};

		// Primero y ultimo
		var first = attr.overlaps[0];
		var last = attr.overlaps[attr.overlaps.length - 1];

		// Para el primero
		if(isPrev(first, attr.begin) || cellComparator(first.begin.cell, attr.begin) <= 0) {
			unionSchedule.begin = first.begin;
		}
		else {
			unionSchedule.begin = {
				hour: parseInt($(attr.begin).attr("hour")),
				minutes: parseInt($(attr.begin).attr("minutes")),
				cell: attr.begin
			};
		}

		// Para el último
		if(isNext(last, attr.end) || cellComparator(last.end.cell, attr.end) >= 0) {
			unionSchedule.end = last.end;
		}
		else {
			unionSchedule.end = {
				hour: parseInt($(attr.end).attr("next-hour")),
				minutes: parseInt($(attr.end).attr("next-minutes")),
				cell: attr.end
			};
		}

		// Borra todos los horarios
		for (var i = 0; i < attr.overlaps.length; i++) {
			removeSchedule(attr.overlaps[i], attr.daySchedules, attr.dayCells);
		}

		// Ponemos la información en su lugar y agregamos
		putInfo(unionSchedule, attr.field);
		addSchedule(unionSchedule, attr.daySchedules, attr.dayCells);

		// Seleccionamos las que quedaron vacias en el drag
		if(unionSchedule.begin.cell != unionSchedule.end.cell) {
			fillRange(unionSchedule.begin.cell, unionSchedule.end.cell, attr.dayCells);
		}
		if($(unionSchedule.begin.cell).hasClass("available-schedule")) {
			$(unionSchedule.begin.cell).removeClass("available-schedule");
			$(unionSchedule.begin.cell).addClass("selected-schedule");
		}
	}

	// Ontiene los horarios solapados
	function getOverlapSchedules (begin, end, daySchedules) {
		var overlapSchedules = new Array();

		// Iteramos los horarios del dia
		for (var i = 0; i < daySchedules.length; i++) {
			var schedule = daySchedules[i];

			// Obtenemos las celdas del horario
			var beginCell = schedule.begin.cell;
			var endCell = schedule.end.cell;

			// Obtenemos una comparacion del rango contra el horario
			var beginIn = (cellComparator(begin, beginCell) <= 0 && cellComparator(beginCell, end) <= 0) ||
						  (cellComparator(beginCell, begin) <= 0 && cellComparator(begin, endCell) <= 0);
			var endIn = (cellComparator(begin, endCell) <= 0 && cellComparator(endCell, end) <= 0) ||
						(cellComparator(beginCell, end) <= 0 && cellComparator(end, endCell) <= 0);

			// Si se solapa, es previo o siguiente de uno lo incluimos
			if(beginIn || endIn || isPrev(schedule, begin) || isNext(schedule, end)) {
				overlapSchedules.push(schedule);
			}
		}

		return overlapSchedules;
	}

	// Evalúa si un horario esta antes del rango
	function isPrev (schedule, begin) {
		var hour = parseInt($(begin).attr("hour"));
		var minutes = parseInt($(begin).attr("minutes"));

		return schedule.end.hour == hour && schedule.end.minutes == minutes;
	}

	// Evalúa si un horario esta despues del rango
	function isNext (schedule, end) {
		var hour = parseInt($(end).attr("next-hour"));
		var minutes = parseInt($(end).attr("next-minutes"));

		return schedule.begin.hour == hour && schedule.begin.minutes == minutes;
	}

	// Pone la informacion del horario en su campo
	function putInfo (schedule, field) {
		$(field).find("input:nth-child(1)").val(schedule.day);
		$(field).find("input:nth-child(2)").val(schedule.begin.hour + ":" + schedule.begin.minutes);
		$(field).find("input:nth-child(3)").val(schedule.end.hour + ":" + schedule.end.minutes);
	}

	// Agrega un horario
	function addSchedule (schedule, daySchedules, dayCells) {

		// Agrega el horario a su día
		daySchedules.push(schedule);

		// Creamos un tache para quitar el horario
		var iconDestroy = document.createElement("i");
		$(iconDestroy).addClass("fa");
		$(iconDestroy).addClass("fa-times");
		$(iconDestroy).css({
			"float": "right",
			"cursor": "pointer",
			"color": "#001f3a"
		});
		$(iconDestroy).click(function () {
			removeSchedule(schedule, daySchedules, dayCells);
		});
		$(schedule.begin.cell).append(iconDestroy);
	}

	// Borra un horario
	function removeSchedule (schedule, schedulesDay, dayCells) {
		
		// Recorremos el dia vaciando
		var onRange = false;
		for (var i = 0; i < dayCells.length; i++) {

			// Comprobamos que ya esté en el rango
			onRange = onRange || (dayCells[i] == schedule.begin.cell);

			// Si esta en el rango
			if(onRange) {

				// Si no esta seleccionada se selecciona
				if($(dayCells[i]).hasClass("selected-schedule")) {
					$(dayCells[i]).empty();
					$(dayCells[i]).removeClass("selected-schedule");
					$(dayCells[i]).addClass("available-schedule");
				}

				// Comprueba si ya terminamos
				if(dayCells[i] == schedule.end.cell) {
					break;
				}
			}
		}

		// Le damos click a su link de removefields
		schedule.field.find(".remove_nested_fields").click();

		// Lo quitamos de su día
		for (var i = 0; i < schedulesDay.length; i++) {
			if(schedulesDay[i] == schedule) {
				schedulesDay.splice(i, 1);
				break;
			}
		}
	}

	// Compara celdas por su id (hora)
	function cellComparator (x, y) {
		var idX = parseInt($(x).attr("id"));
		var idY = parseInt($(y).attr("id"));
		return idX - idY;
	}

	// Parsea una hora
	function parseHour(hour) {
		if(hour.lastIndexOf("2000-01-01") == -1) {
			hour = "2000-01-01 " + hour;
		}

		var date = new Date(hour);
		return [date.getHours(), date.getMinutes()];
	}

	// Obtiene una celda por su id
	function getCell(day, hour, minutes, begin) {
		var hourStr = ("" + hour).length == 1 ? "0" + hour : "" + hour;
		var minutesStr = ("" + minutes).length == 1 ? "0" + minutes : "" + minutes;

		var selector = "td[day='" + day + "']";
		if(begin) {
			selector += "[hour='" + hourStr + "'][minutes='" + minutesStr + "']";
		} else {
			selector += "[next-hour='" + hourStr + "'][next-minutes='" + minutesStr + "']";
		}

		return $(selector)[0];
	}
}