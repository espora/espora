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
		when 'SolicitudesVsAtendidos '
			@graphAtendidos = Gchart.pie(
				:size   => '300x200',
				:title  => "Solicitudes y de alumnos atendidos",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'Sexo'
			@graphSexo = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'Edad'
			@graphEdad = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'Familiar'
			@graphFamiliar = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'Procedencia'
			@graphProcedencia = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'Semestre'
			@graphSemestre = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'Materias'
			@graphMaterias = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'Eficiencia'
			@graphEficiencia = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'Motivos'
			@graphMotivos = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'Sintomas'
			@graphSintomas = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'AreasAfectadas'
			@graphAfectadas = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'AreasBeneficiadas'
			@graphBeneficiadas = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'EdoEmocionalAntes'
			@graphEmoAntes = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'EdoEmocionalDespues'
			@graphEmoDespues= Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'Ayudo'
			@graphAyudo = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'Difusion'
			@graphDifusion = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end
		case params[:graph]
		when 'Recomendacion'
			@graphRecomendacion = Gchart.pie(
				:size   => '300x200',
				:title  => "Grafica de Pastel- Carreras de la facultad",
				:legend => ['Biologia', 'Matematicas', 'Ciencias de la computacion', 'Actuaria', 'Fisica'],
				:custom => "chco=FFF110,FF0000",
				:data   => [120, 45, 25, 55, 20]
			)
		end

		render partial: "graph"
	end
end
