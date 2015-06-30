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
		var beginCell = getCell(day, beginH[0], beginH[1]);
		var endCell = getCell(day, endH[0], endH[1]);
		
		// Usamos el manejador de horarios
		$(beginCell).removeClass("available-schedule");
		$(beginCell).addClass("selected-schedule");

		activeDay = day;
		handleRange([beginCell, endCell], schedules[day - 1], scheduleCells[day - 1], $(this));
	});

	/********* INTERACCION ***********/

	// Mouse presionado sobre un horario
	$(config.table).find("td").mousedown(function () {

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

			// Creamos el rango
			$(".add_nested_fields[data-association=request_schedules]").click();
		}
	});

	// Al agregar un horario
	$(document).on("nested:fieldAdded:request_schedules", function( event ) {

		// Manejamos el rango
		handleRange(activeRange, schedules[activeDay - 1], scheduleCells[activeDay - 1], event.field);

		// Desactivamos el rango
		activeDay = -1;
		activeRange = undefined;
	});

	/********* FUNCIONES ***********/

	// Maneja un rango creado
	function handleRange (range, schedulesDay, dayCells, field) {

		// Obtenemos el principio y final
		var begin = range[0];
		var end = range[range.length - 1];

		// Obtenemos los horarios que solapados
		var overlapSchedules = getOverlapSchedules(begin, day, schedulesDay);
		console.log(overlapSchedules);

		// Si es disjunto
		if(overlapSchedules.length == 0) {

			// Seleccionamos las que quedaron vacias en el drag
			if(begin != end) {
				fillRange(begin, end, dayCells);
			}

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
				field: field,
				day: activeDay
			};

			// Ponemos la información en su lugar
			$(field).find("input:nth-child(1)").val(activeDay);
			$(field).find("input:nth-child(2)").val($(begin).attr("hour") + ":" + $(begin).attr("minutes"));
			$(field).find("input:nth-child(3)").val($(begin).attr("next-hour") + ":" + $(begin).attr("next-minutes"));

			addSchedule(newSchedule, schedulesDay, dayCells);
		}

		// Hubo solapados
		else {
			mergeSchedules(begin, end, overlapSchedules, activeDay, field, schedulesDay, dayCells);
		}
	}

	// Mezcla los rangos
	function mergeSchedules (begin, end, overlapSchedules, day, field, schedulesDay, dayCells) {

		// Creamos el horario unión
		var unionSchedule = {
			begin: undefined,
			end: undefined,
			field: field,
			day: day
		};

		// Primero y ultimo
		var first = overlapSchedules[0];
		var last = overlapSchedules[overlapSchedules.length - 1];

		// Para el primero
		if(isPrev(first, begin) || cellComparator(first.begin.cell, begin) <= 0) {
			unionSchedule.begin = first.begin;
		}
		else {
			unionSchedule.begin = {
				hour: parseInt($(begin).attr("hour")),
				minutes: parseInt($(begin).attr("minutes")),
				cell: begin
			};
		}

		// Para el último
		if(isNext(last, end) || cellComparator(last.end.cell, end) >= 0) {
			unionSchedule.end = last.end;
		}
		else {
			unionSchedule.end = {
				hour: parseInt($(end).attr("next-hour")),
				minutes: parseInt($(end).attr("next-minutes")),
				cell: end
			};
		}

		// Ponemos la información en su lugar
		$(field).find("input:nth-child(1)").val(activeDay);
		$(field).find("input:nth-child(2)").val($(begin).attr("hour") + ":" + $(begin).attr("minutes"));
		$(field).find("input:nth-child(3)").val($(begin).attr("next-hour") + ":" + $(begin).attr("next-minutes"));

		// Borra todos los horarios
		for (var i = 0; i < overlapSchedules.length; i++) {
			removeSchedule(overlapSchedules[i], schedulesDay, dayCells);
		}

		// Agrega el horario de union
		addSchedule(unionSchedule, schedulesDay, dayCells);

		// Seleccionamos las que quedaron vacias en el drag
		if(unionSchedule.begin.cell != unionSchedule.end.cell) {
			fillRange(unionSchedule.begin.cell, unionSchedule.end.cell, dayCells);
		}
		if($(unionSchedule.begin.cell).hasClass("available-schedule")) {
			$(unionSchedule.begin.cell).removeClass("available-schedule");
			$(unionSchedule.begin.cell).addClass("selected-schedule");
		}
	}

	// Agrega un horario
	function addSchedule (schedule, schedulesDay, dayCells) {

		// Agrega el horario a su día
		schedulesDay.push(schedule);

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
			removeSchedule(schedule, schedulesDay, dayCells);
		});
		$(schedule.begin.cell).append(iconDestroy);
	}

	// Borra un horario
	function removeSchedule (schedule, schedulesDay, dayCells) {
		
		// Recorremos el dia vaciando
		var onRange = false;
		for (var i = 0; i < dayCells.length; i++) {

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
			} else {

				// Comprobamos que ya esté en el rango
				onRange = (dayCells[i] == schedule.begin.cell);
				if($(dayCells[i]).hasClass("selected-schedule")) {
					$(dayCells[i]).empty();
					$(dayCells[i]).removeClass("selected-schedule");
					$(dayCells[i]).addClass("available-schedule");
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

	// Selecciona las celdas que estan entre dos
	function fillRange (begin, end, dayCells) {

		// Recorremos el dia rellenando
		var onRange = false;
		for (var i = 0; i < dayCells.length; i++) {

			// Si esta en el rango
			if(onRange) {

				// Si no esta seleccionada se selecciona
				if($(dayCells[i]).hasClass("available-schedule")) {
					$(dayCells[i]).removeClass("available-schedule");
					$(dayCells[i]).addClass("selected-schedule");
				}

				// Comprueba si ya terminamos
				if(dayCells[i] == end) {
					break;
				}
			} else {

				// Comprobamos que ya esté en el rango
				onRange = (dayCells[i] == begin);
			}
		}
	}

	// Ontiene los horarios solapados
	function getOverlapSchedules (begin, end, schedulesDay) {
		var overlapSchedules = new Array();

		// Iteramos los horarios del dia
		for (var i = 0; i < schedulesDay.length; i++) {
			var schedule = schedulesDay[i];

			// Obtenemos una comparacion del rango contra el horario
			var compareBegin = cellComparator(schedule.begin.cell, begin);
			var compareEnd = cellComparator(begin, schedule.end.cell);
			var beginIn = compareBegin <= 0 && compareEnd <= 0;

			compareBegin = cellComparator(schedule.begin.cell, end);
			compareEnd = cellComparator(end, schedule.end.cell);
			var endIn = compareBegin <= 0 && compareEnd <= 0;			

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

	// Compara celdas por su id (hora)
	function cellComparator (x, y) {
		var idX = parseInt($(x).attr("id"));
		var idY = parseInt($(y).attr("id"));
		return idX - idY;
	}
}