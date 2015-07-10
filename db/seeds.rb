# coding: utf-8

puts ":::: Poblando Espora BD...\n\n"

# -----> POBLANDO LA BASE <-----

load "#{Rails.root}/db/population.rb"

# -----> CATALOGO ESTATUS DE PACIENTE <-----

PatientStatusType.delete_all
patient_satus_entries = [
	{ id: "1", name: "Sin contactar" },
	{ id: "2", name: "Esperando respuesta" },
	{ id: "3", name: "En tratamiento" },
	{ id: "4", name: "Ya no esta interesado" },
	{ id: "5", name: "Baja" }
]

puts "\n--- Poblando catálogo de Estatus de Paciente (#{patient_satus_entries.count} inserciones)... "
patient_satus_created = PatientStatusType.create(patient_satus_entries)
puts "   #{PatientStatusType.all.count} inserciones hechas al catálogo de Estatus de Paciente."

# -----> CATALOGO AREAS AFECTADAS <-----

PersonalAreaType.delete_all
personal_area_entries = [
	{ id: "1", name: "Escolar" },
	{ id: "2", name: "Familiar" },
	{ id: "3", name: "Social" },
	{ id: "4", name: "Laboral" },
	{ id: "5", name: "Pareja" },
	{ id: "6", name: "Sexual" },
	{ id: "7", name: "Emocional" },
	{ id: "8", name: "Otro" }
]

puts "\n--- Poblando catálogo de Áreas personales (#{personal_area_entries.count} inserciones)... "
affectedarea_created = PersonalAreaType.create(personal_area_entries)
puts "   #{PersonalAreaType.all.count} inserciones hechas al catálogo Áreas personales."

# -----> CATALOGO CONDICION <-----

ConditionType.delete_all
condition_entries = [
	{ id: "1", name: "Muy mal" },
	{ id: "2", name: "Mal" },
	{ id: "3", name: "Regular" },
	{ id: "4", name: "Bien" },
	{ id: "5", name: "Muy bien" }
]

puts "\n--- Poblando catálogo de Condición (#{condition_entries.count} inserciones)... "
condition_created = ConditionType.create(condition_entries)
puts "   #{ConditionType.all.count} inserciones hechas al catálogo de Condición."

# -----> CATALOGO MOTIVOS DE CONSULTA <-----

ReasonsType.delete_all
reasons_entries = [
	{ id: "1", name: "Adicciones" },
	{ id: "2", name: "Alimentación" },
	{ id: "3", name: "Ansiedad y angustia" },
	{ id: "4", name: "Autoconocimiento" },
	{ id: "5", name: "Autoestima" },
	{ id: "6", name: "Ayuda, dudas y orientación" },
	{ id: "7", name: "Depresión y tristeza" },
	{ id: "8", name: "Deseo de sentirse bien" },
	{ id: "9", name: "Elección de carrera" },
	{ id: "10", name: "Emocionales y psicológicos" },
	{ id: "11", name: "Escolares" },
	{ id: "12", name: "Estrés" },
	{ id: "13", name: "Familiares" },
	{ id: "14", name: "Físicos" },
	{ id: "15", name: "Fobias y miedos" },
	{ id: "16", name: "Mejorar como persona" },
	{ id: "17", name: "Pareja" },
	{ id: "18", name: "Relacionarse" },
	{ id: "19", name: "Separaciones, muertes y duelos" },
	{ id: "20", name: "Sexuales" },
	{ id: "21", name: "Sueño" },
	{ id: "22", name: "Otros" },
	{ id: "23", name: "Platicar" }
]

puts "\n--- Poblando catálogo de Motivos de consulta (#{reasons_entries.count} inserciones)... "
reasons_created = ReasonsType.create(reasons_entries)
puts "   #{ReasonsType.all.count} inserciones hechas al catálogo de Motivos de consulta."

# -----> CATALOGO COMO CONOCIO <-----

HowMetType.delete_all
howmet_entries = [
	{ id: "1", name: "Cartel" },
	{ id: "2", name: "Amigos y/o conocidos" },
	{ id: "3", name: "Página de la Facultad" },
	{ id: "4", name: "Maestros o Tutores" },
	{ id: "5", name: "Platica Informativa o Bienvenida" },
	{ id: "6", name: "Otro" }
]

puts "\n--- Poblando catálogo de Como conoció (#{howmet_entries.count} inserciones)... "
howmet_created = HowMetType.create(howmet_entries)
puts "   #{HowMetType.all.count} inserciones hechas al catálogo de Como conocio."

# -----> CATALOGO CIE10 <-----

Cie10Type.delete_all
cie10_entries = [
	{ id: "1", name: "Trastornos mentales orgánicos" },
	{ id: "2", name: "Trastornos mentales y del comportamiento debido al consumo" },
	{ id: "3", name: "Esquizofrenia y trastornos de ideas delirantes" },
	{ id: "4", name: "Trastornos del humor o afectivos" },
	{ id: "5", name: "Trastornos neuróticos" },
	{ id: "6", name: "Trastornos del comportamiento asociados a disfunciones fisiológicas" },
	{ id: "7", name: "Trastornos de la personalidad y del comportamiento" }
]

puts "\n--- Poblando catálogo CIE10 (#{cie10_entries.count} inserciones)... "
cie10_created = Cie10Type.create(cie10_entries)
puts "   #{Cie10Type.all.count} inserciones hechas al catálogo CIE10."

# -----> CATALOGO MECANISMOS <-----

MechanismType.delete_all
mechanism_entries = [
	{ id: "1",  name: "Represión" },
	{ id: "2",  name: "Negación " },
	{ id: "3",  name: "Identificación proyectiva" },
	{ id: "4",  name: "Control omnipotente" },
	{ id: "5",  name: "Intelectualización" },
	{ id: "6",  name: "Ascetismo" },
	{ id: "7",  name: "Racionalización" },
	{ id: "8",  name: "Transformación en lo contrario" },
	{ id: "9",  name: "Vuelta sobre sí mismo" },
	{ id: "10", name: "Escisión" },
	{ id: "11", name: "Desmentida" },
	{ id: "12", name: "Idealización" },
	{ id: "13", name: "Proyección" },
	{ id: "14", name: "Desplazamiento" },
	{ id: "15", name: "Aislamiento" },
	{ id: "16", name: "Anulación" },
	{ id: "17", name: "Form. Reactiva" },
	{ id: "18", name: "Sublimación" }
]

puts "\n--- Poblando catálogo de Mecanismos (#{mechanism_entries.count} inserciones)... "
mechanism_created = MechanismType.create(mechanism_entries)
puts "   #{MechanismType.all.count} inserciones hechas al catálogo de Mecanismos."

# -----> CATALOGO RASGOS PATERNOS <-----

PaternalTraitType.delete_all
paternal_trait_entries = [
	{ id: "1",  name: "Agresivo" },
	{ id: "2",  name: "Ambivalente" },
	{ id: "3",  name: "Ansioso" },
	{ id: "4",  name: "Ausente" },
	{ id: "5",  name: "Autoritario" },
	{ id: "6",  name: "Cariñoso" },
	{ id: "7",  name: "Comprensivo" },
	{ id: "8",  name: "Dependiente" },
	{ id: "9",  name: "Depresivo" },
	{ id: "10", name: "Enojón" },
	{ id: "11", name: "Impulsivo" },
	{ id: "12", name: "Insatisfecho" },
	{ id: "13", name: "Inseguro" },
	{ id: "14", name: "Masoquista" },
	{ id: "15", name: "Negligente" },
	{ id: "16", name: "Obsesivo" },
	{ id: "17", name: "Paranoide" },
	{ id: "18", name: "Pasivo" },
	{ id: "19", name: "Sobreprotector" },
	{ id: "20", name: "Transgresor" }
]

puts "\n--- Poblando catálogo de Rasgos Paternos (#{paternal_trait_entries.count} inserciones)... "
paternal_trait_created = PaternalTraitType.create(paternal_trait_entries)
puts "   #{PaternalTraitType.all.count} inserciones hechas al catálogo de Rasgos Paternos."

# -----> CATALOGO SITUACIONES Y EXPERIENCIAS <-----

ExperienceType.delete_all
experience_entries = [
	{ id: "1",  name: "Ausencia de algún padre" },
	{ id: "2",  name: "Aborto" },
	{ id: "3",  name: "Abuso sexual" },
	{ id: "4",  name: "Bullying" },
	{ id: "5",  name: "Carencias económicas" },
	{ id: "6",  name: "Conflicto con madre o padre" },
	{ id: "7",  name: "Duelo no elaborado" },
	{ id: "8",  name: "Enfermedad/discapacidad" },
	{ id: "9",  name: "Fracaso escolar" },
	{ id: "10", name: "Hacinamiento" },
	{ id: "11", name: "Maltrato psicológico familiar" },
	{ id: "12", name: "Relación destructiva" },
	{ id: "13", name: "Rivalidad Fraterna" },
	{ id: "14", name: "Separación de los padres" },
	{ id: "15", name: "Violencia intrafamiliar" },
]

puts "\n--- Poblando catálogo de Situaciones y Experiencias (#{experience_entries.count} inserciones)... "
experience_created = ExperienceType.create(experience_entries)
puts "   #{ExperienceType.all.count} inserciones hechas al catálogo de Situaciones y Experiencias."

# -----> CATALOGO ESTRUCTURA CLINICA <-----

ClinicalStructureType.delete_all
clinical_structure_entries = [
	{ id: "1", name: "Neurosis obsesiva" },
	{ id: "2", name: "Histérica" },
	{ id: "3", name: "Fobia" },
	{ id: "4", name: "Border" },
	{ id: "5", name: "Psicosis" }
]

puts "\n--- Poblando catálogo de Estructura Clinica (#{clinical_structure_entries.count} inserciones)... "
clinical_structure_created = ClinicalStructureType.create(clinical_structure_entries)
puts "   #{ClinicalStructureType.all.count} inserciones hechas al catálogo de Estructura Clinica."

# -----> CATALOGO SIGNOS Y SINTOMAS <-----

SymptomType.delete_all
symptom_entries = [
	{ id: "1",  name: "Agresividad" },
	{ id: "2",  name: "Aislamiento" },
	{ id: "3",  name: "Alcoholismo" },
	{ id: "4",  name: "Alucinaciones" },
	{ id: "5",  name: "Ansiedad y Estrés" },
	{ id: "6",  name: "Ataque de pánico" },
	{ id: "7",  name: "Atracones" },
	{ id: "8",  name: "Auto sabotaje" },
	{ id: "9",  name: "Autolesiones" },
	{ id: "10", name: "Autorreproches" },
	{ id: "11", name: "Celos" },
	{ id: "12", name: "Confusión" },
	{ id: "13", name: "Culpa" },
	{ id: "14", name: "Dependencia" },
	{ id: "15", name: "Desesperación" },
	{ id: "16", name: "Desesperanza" },
	{ id: "17", name: "Desinterés" },
	{ id: "18", name: "Dificultad adaptación" },
	{ id: "19", name: "Dificultad para estudiar" },
	{ id: "20", name: "Enojo" },
	{ id: "21", name: "Envidia" },
	{ id: "22", name: "Exigencias elevadas" },
	{ id: "23", name: "Falta de apetito" },
	{ id: "24", name: "Flojera" },
	{ id: "25", name: "Fobias" },
	{ id: "26", name: "Hiperactividad" },
	{ id: "27", name: "Hipocondría" },
	{ id: "28", name: "Ideación suicida" },
	{ id: "29", name: "Ideas obsesivas" },
	{ id: "30", name: "Ideas paranoides" },
	{ id: "31", name: "Identidad sexual" },
	{ id: "32", name: "Inestabilidad emocional" },
	{ id: "33", name: "Insatisfacción" },
	{ id: "34", name: "Insomnio" },
	{ id: "35", name: "Intento de suicidio" },
	{ id: "36", name: "Miedo a participar" },
	{ id: "37", name: "Preocupación calorías" },
	{ id: "38", name: "Problemas de autoestima" },
	{ id: "39", name: "Problemas para relacionarse" },
	{ id: "40", name: "Rituales" },
	{ id: "41", name: "Soledad" },
	{ id: "42", name: "Somatización" },
	{ id: "43", name: "Taquicardia" },
	{ id: "44", name: "Tristeza" },
	{ id: "45", name: "Vómito" }
]

puts "\n--- Poblando catálogo de Signos y Síntomas (#{symptom_entries.count} inserciones)... "
symptom_created = SymptomType.create(symptom_entries)
puts "   #{SymptomType.all.count} inserciones hechas al catálogo de Signos y Síntomas."

# -----> CATALOGO TIPO DE BAJAS <-----

PatientDropoutType.delete_all
dropout_entries = [
	{ id: "1", name: "Interrupción" },
	{ id: "2", name: "Canalizado" },
	{ id: "3", name: "Abandono" },
	{ id: "4", name: "Finalizado" }
]

puts "\n--- Poblando catálogo de Tipos de Baja (#{dropout_entries.count} inserciones)... "
dropouts_created = PatientDropoutType.create(dropout_entries)
puts "   #{PatientDropoutType.all.count} inserciones hechas al catálogo de Tipos de Baja."

# -----> CATALOGO NIVEL DE AYUDA <-----

AidLevelType.delete_all
aid_level_entries = [
	{ id: "1", name: "No me ayudó" },
	{ id: "2", name: "Me ayudó poco" },
	{ id: "3", name: "Me ayudó moderadamente" },
	{ id: "4", name: "Me ayudó mucho" },
	{ id: "5", name: "Me ayudó totalmente" }
]

puts "\n--- Poblando catálogo de Como te ayudo (#{aid_level_entries.count} inserciones)... "
aid_level_created = AidLevelType.create(aid_level_entries)
puts "   #{AidLevelType.all.count} inserciones hechas al catálogo de Como te ayudo."

# -----> CATALOGO COMO LO RECOMIENDAS <-----

AdviseLevelType.delete_all
advise_level_entries = [
	{ id: "1", name: "Nada" },
	{ id: "2", name: "Poco" },
	{ id: "3", name: "Medio" },
	{ id: "4", name: "Mucho" },
	{ id: "5", name: "Completamente" }
]

puts "\n--- Poblando catálogo de Como lo recomendarias (#{advise_level_entries.count} inserciones)... "
advise_level_created = AdviseLevelType.create(advise_level_entries)
puts "   #{AdviseLevelType.all.count} inserciones hechas al catálogo de Como lo recomendarias."

