class StadisticsController < ApplicationController

	# Layout de terapeuta
	layout "therapist", :only => [ :index ]

	def index

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 0

		# Panel para las tabs del workspace del perfil
		@profile_active_tab = 1
	end

	def graph

		case params[:graph]
		when 'SolicitudesVsAtendidos'
			@graph = Gchart.line(
                    :size   => '600x400',
                    :title  => "Número de solicitudes vs alumnos atendidos",
                    :legend => ['Número de alumnos atendidos', 'Número de solucitudes recibidas'],
                    :bar_colors => ['000000', '0088FF'],
                    :data   => [[47, 55, 87, 85, 95],[47, 80, 129, 176, 202]],
                    :bg => 'EFEFEF',
                   	:legend_position => 'bottom',
                   	:axis_with_labels => [['x'], ['y']],
                   	:max_value => 202,
                   	:min_value => 0,
                   	:axis_labels => [["Semestre 2011-2|Semestre 2012-1|Semestre 2012-2|Semestre 2013-1|Semestre 2013-2"]]
            )

		when 'SexoSol'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Sexo de Solicitantes",
				:legend => ['Hombres', 'Mujeres'],
				:custom => "chco=8856a7,9ebcda",
				:data   => [120, 245],
				:labels => ["120", "245"],
				:bg => 'EFEFEF'
			)
		when 'SexoAten'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Sexo de Atendidos",
				:legend => ['Hombres', 'Mujeres'],
				:custom => "chco=8856a7,9ebcda",
				:data   => [34, 80],
				:labels => ["34", "80"],
				:bg => 'EFEFEF'
			)

		when 'Familiar'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Estructura Familiar",
				:legend => ['Con ambos padres', 'Solo con madre','Solo padre', 'Otros familiares', 'Amigos', 'Pareja'],
				:custom => "chco=fa9fb5fa9fb5, c51b8ac51b8a",
				:data   => [53, 33, 3, 5, 5, 1],
				:labels => ["53%", "33%", "3%", "5%", "5%", "1%"],
				:bg => 'EFEFEF'
			)

		when 'CarreraSol'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Carrera de precedencia de alumnos solicitantes",
				:legend => ['Bilogia', 'Actuaría', 'Física', 'Matemáticas', 'Ciencias de la Computación', 'Ciencias de la Tierra'],
				:custom => "chco=43a2ca,e0f3db",
				:data   => [53, 33, 3, 5, 5, 1],
				:labels => ["53%", "33%", "3%", "5%", "5%", "1%"],
				:bg => 'EFEFEF'
			)

		when 'CarreraAten'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Carrera de precedencia de alumnos atendidos",
				:legend => ['Bilogia', 'Actuaría', 'Física', 'Matemáticas', 'Ciencias de la Computación', 'Ciencias de la Tierra'],
				:custom => "chco=43a2ca,e0f3db",
				:data   => [39, 21, 18, 12, 4, 7],
				:labels => ["39%", "21%", "18%", "12%", "4%", "7%"],
				:bg => 'EFEFEF'
			)

		when 'SemestreSol'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Semestre de precedencia de alumnos solicitantes",
				:legend => ['1°', '2°', '3°', '4°', '5°', '6°', '7°', '8°'],
				:custom => "chco=FFF110,FF0000",
				:data   => [39, 21, 18, 12, 4, 3, 2, 1],
				:labels => ["39%", "21%", "18%", "12%", "4%", "3%", "2%", "1%"],
				:bg => 'EFEFEF'
			)

		when 'SemestreAten'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Semestre de precedencia de alumnos atendidos",
				:legend => ['1°', '2°', '3°', '4°', '5°', '6°', '7°', '8°'],
				:custom => "chco=FFF110,FF0000",
				:data   => [39, 21, 18, 12, 4, 3, 2, 1],
				:labels => ["39%", "21%", "18%", "12%", "4%", "3%", "2%", "1%"],
				:bg => 'EFEFEF'
			)

		when 'MateriasSol'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Adeudo de materias de solicitantes",
				:legend => ['0', '1', '2', '3', '4', '5', '6', '7', '8'],
				:custom => "chco=FFF110,FF0000",
				:data   => [39, 21, 18, 12, 4, 3, 2, 1],
				:labels => ["39%", "21%", "18%", "12%", "4%", "3%", "2%", "1%"],
				:bg => 'EFEFEF'
			)

		when 'MateriasAten'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Adeudo de materias de atendidos",
				:legend => ['0', '1', '2', '3', '4', '5', '6', '7', '8'],
				:custom => "chco=FFF110,FF0000",
				:data   => [39, 21, 18, 12, 4, 3, 2, 1],
				:labels => ["39%", "21%", "18%", "12%", "4%", "3%", "2%", "1%"],
				:bg => 'EFEFEF'
			)








		when 'Eficiencia'
			@graph = Gchart.bar(
				:size   => '600x400',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		when 'Motivos'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		when 'Sintomas'
			@graph = Gchart.bar(
            :size => '800x00',
            :bar_colors => ['000000'],
            :title => "Signos y síntomas",
            :bg => 'EFEFEF',
            :legend => ['Tristeza ', 'Autoestima', 'Insatisfacción', 'Enojo', 'Estrés', 'Dif. estudiar', 'Ansiedad', 'Prob. para relacionarse', 'Exigencias elevadas', 'Desesperanza', 'Miedo a participar', 'Ideas suicidas', 'Intento de suicidio'],
            :data => [83, 66, 65.7, 33.8, 60.8, 60.1, 55.5, 49.4, 29, 28.6, 20, 15.1, 3],
            :encoding => 'simple',
            :stacked => false,
            :legend_position => 'bottom',
            :axis_with_labels => [['x'], ['y']],            
            :max_value => 84,
            :min_value => 0,
            :axis_labels => [["83%|66%|65.7%|33.8%|60.8%|60.1%|55.5%|49.4%|29%|28.6%|20%|15.1%|3%]"]]
            )   
		when 'AreasAfectadas'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		when 'AreasBeneficiadas'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		when 'EdoEmocionalAntes'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		when 'EdoEmocionalDespues'
			@graph= Gchart.pie(
				:size   => '600x400',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		when 'Ayudo'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		when 'Difusion'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		when 'Recomendacion'
			@graph = Gchart.pie(
				:size   => '600x400',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		else
		end

		render partial: "graph"
	end
end