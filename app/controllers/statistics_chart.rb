class StatisticsChart

	def self.settings
		chart_settings = {
			"request_on_attended" => {
				:options => {
					:title     => "Numero de Solicitudes y Alumnos Atendidos",
					:width     => 450,
					:height    => 200,
					:curveType => "function",
					:legend    => { position: "bottom" }
				},
				:chartType => "linechart"
			},
			"sex_requests" => {
				:options => {
					:title  => "Sexo de los alumnos que han solicitado el servicio",
					:width  => 400,
					:height => 400
				},
				:chartType => "piechart"
			},
			"sex_attended" => {
				:options => {
					:title  => "Sexo de los alumnos que se han atendido en ESPORA",
					:width  => 400,
					:height => 400
				},
				:chartType => "piechart"
			},
			"career_requests" => {
				:options => {
					:title  => 'Carrera de procedencia de alumnos solicitantes',
		    	:width  => 500,
		    	:height => 500
				},
				:chartType => "piechart"
			},
      "career_attended" => {
        :options => {
          :title  => 'Carrera de procedencia de alumnos atendidos',
          :width  => 500,
          :height => 500
        },
        :chartType => "piechart"
      },
      "semester_requests" => {
        :options => {
          :title  => 'Semestre que estan cursando los alumnos solicitantes',
          :width  => 500,
          :height => 500
        },
        :chartType => "piechart"
      },
      "semester_attended" => {
        :options => {
          :title  => 'Semestre que estan cursando los alumnos solicitantes',
          :width  => 500,
          :height => 500
        },
        :chartType => "piechart"
      },
      "failed_subjects_requests" => {
      	:options => {
      		:title  => 'Cantidad de materias reprobadas por los alumnos solicitantes',
      		:width  => 500,
      		:height => 500
      	},
      	:chartType => "piechart"
      },
      "failed_subjects_attended" => {
      	:options => {
      		:title  => 'Cantidad de materias reprobadas por los alumnos atendidos',
      		:width  => 500,
      		:height => 500
      	},
      	:chartType => "piechart"
      },
      "dropouts" => {
      	:options => {
      		:title  => 'Reporte de bajas',
      		:width  => 900,
      		:height => 400
      	},
      	:chartType => "piechart"
      },
      "reasons" => {
				:options => {
					:title => 'Motivos de consulta señalados por los alumnos',
					:width => 1000,
					:heigh => 700
				},
				:chartType => "barchart"
			},
			"symptoms" => {
				:options => {
					:title  => 'Signos y síntomas más frecuentes en los pacientes',
					:width  => 1000,
					:height => 1200
				},
				:chartType => "barchart"
			},
			"affected_areas" => {
				:options => {
					:title  => 'Areas afectadas del alumno con relación al motivo de consulta',
					:width  => 1000,
					:heigh  => 400,
					:legend => { position: "ne" }
				},
				:chartType => "columnchart"
			},
			"improved_areas" => {
				:options => {
					:title  => 'Areas beneficiadas del alumno con relación al motivo de consulta',
					:width  => 1000,
					:heigh  => 400,
					:legend => { position: "ne" }
				},
				:chartType => "columnchart"
			},
			"condition_before" => {
				:options => {
					:title  => 'Estado emocional de los pacientes antes del tratamiento',
					:width  => 900,
					:height => 400
				},
				:chartType => "piechart"
			},
			"condition_after" => {
				:options => {
					:title  => 'Estado emocional de los pacientes después de finalizar el tratamient =>',
					:width  => 900,
					:height =>400
				},
				:chartType => "piechart"
			},
			"aid" => {
				:options => {
					:title  => 'Opinión del paciente con relación a su motivo de consulta',
					:width  => 900,
					:height => 400
				},
				:chartType => "piechart"
			},
			"advise" => {
				:options => {
					:title  =>'Recomendación de los pacientes que finalizaron el tratamiento',
					:width  => 900,
					:height => 400
				},
				:chartType => "piechart"
			},
			"how_met" => {
				:options => {
					:title  => 'Medios de difusión del espacio',
					:width  => 900,
					:height => 400
				},
				:chartType => "piechart"
			},
			"rating" => {
				:options => {
					:title  => 'Calificación del espacio según los alumnos que finalizaron',
					:width  => 900,
					:height => 400
				},
				:chartType => "piechart"
			}
		}

		return chart_settings
	end
end