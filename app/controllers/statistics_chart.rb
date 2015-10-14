class StatisticsChart

	def self.settings
		chart_settings = {
			"request_on_attended" => {
				:options => {
					:title => "Numero de Solicitudes y Alumnos Atendidos",
					:width => 450, :height => 200,
					:curveType => "function",
					:legend => { position: "bottom" }
				},
				:chartType => "linechart"
			},
			"sex_requests" => {
				:options => {
					:title "Sexo de los alumnos que han solicitado el servicio",
					:width => 800, :height => 400,
				},
				:chartType => "piechart"
			},
			,
			"sex_attended" => {
				:options => {
					:title "Sexo de los alumnos que se han atendido en ESPORA",
					:width => 800,
					:height => 400,
				},
				:chartType => "piechart"
			}
		}

		return chart_settings
	end
end