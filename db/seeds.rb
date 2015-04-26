# coding: utf-8
puts ":::: Poblando Espora BD...\n\n"

# -----> CATALOGO CIE10 <-----

Cie10Type.delete_all
cie10_entries = [
	{ name: "Trastornos mentales orgánicos" },
	{ name: "Trastornos mentales y del comportamiento debido al consumo" },
	{ name: "Esquizofrenia y trastornos de ideas delirantes" },
	{ name: "Trastornos del humor o afectivos" },
	{ name: "Trastornos neuróticos" },
	{ name: "Trastornos del comportamiento asociados a disfunciones fisiológicas" },
	{ name: "Trastornos de la personalidad y del comportamiento" },
	{ name: "Sin especificar" }
]

puts "--- Poblando catálogo CIE10 (#{cie10_entries.count} inserciones)... "
cie10_created = Cie10Type.create(cie10_entries)
puts "   #{Cie10Type.all.count} inserciones hechas al catálogo CIE10."

# -----> CATALOGO MECANISMOS <-----

MechanismType.delete_all
mechanism_entries = [
	{ name: "Represión" },
	{ name: "Negación " },
	{ name: "Identificación proyectiva" },
	{ name: "Control omnipotente" },
	{ name: "Intelectualización" },
	{ name: "Ascetismo" },
	{ name: "Racionalización" },
	{ name: "Transformación en lo contrario" },
	{ name: "Vuelta sobre sí mismo" },
	{ name: "Escisión" },
	{ name: "Desmentida" },
	{ name: "Idealización" },
	{ name: "Proyección" },
	{ name: "Desplazamiento" },
	{ name: "Aislamiento" },
	{ name: "Anulación" },
	{ name: "Form. Reactiva" },
	{ name: "Sublimación" },
	{ name: "Sin especificar" }
]

puts "--- Poblando catálogo de Mecanismos (#{mechanism_entries.count} inserciones)... "
mechanism_created = MechanismType.create(mechanism_entries)
puts "   #{MechanismType.all.count} inserciones hechas al catálogo de Mecanismos."

# -----> CATALOGO RASGOS PATERNOS <-----

PaternalTraitType.delete_all
paternal_trait_entries = [
	{ name: "Agresivo" },
	{ name: "Ambivalente" },
	{ name: "Ansioso" },
	{ name: "Ausente" },
	{ name: "Autoritario" },
	{ name: "Cariñoso" },
	{ name: "Comprensivo" },
	{ name: "Dependiente" },
	{ name: "Depresivo" },
	{ name: "Enojón" },
	{ name: "Impulsivo" },
	{ name: "Insatisfecho" },
	{ name: "Inseguro" },
	{ name: "Masoquista" },
	{ name: "Negligente" },
	{ name: "Obsesivo" },
	{ name: "Paranoide" },
	{ name: "Pasivo" },
	{ name: "Sobreprotector" },
	{ name: "Transgresor" },
	{ name: "Sin especificar" }
]

puts "--- Poblando catálogo de Rasgos Paternos (#{paternal_trait_entries.count} inserciones)... "
paternal_trait_created = PaternalTraitType.create(paternal_trait_entries)
puts "   #{PaternalTraitType.all.count} inserciones hechas al catálogo de Rasgos Paternos."

# -----> CATALOGO SITUACIONES Y EXPERIENCIAS <-----

ExperienceType.delete_all
experience_entries = [
	{ name: "Ausencia de algún padre" },
	{ name: "Aborto" },
	{ name: "Abuso sexual" },
	{ name: "Bullying" },
	{ name: "Carencias económicas" },
	{ name: "Conflicto con madre o padre" },
	{ name: "Duelo no elaborado" },
	{ name: "Enfermedad/discapacidad" },
	{ name: "Fracaso escolar" },
	{ name: "Hacinamiento" },
	{ name: "Maltrato psicológico familiar" },
	{ name: "Relación destructiva" },
	{ name: "Rivalidad Fraterna" },
	{ name: "Separación de los padres" },
	{ name: "Violencia intrafamiliar" },
	{ name: "Sin especificar" }
]

puts "--- Poblando catálogo de Situaciones y Experiencias (#{experience_entries.count} inserciones)... "
experience_created = ExperienceType.create(experience_entries)
puts "   #{ExperienceType.all.count} inserciones hechas al catálogo de Situaciones y Experiencias."

# -----> CATALOGO ESTRUCTURA CLINICA <-----

ClinicalStructureType.delete_all
clinical_structure_entries = [
	{ name: "Neurosis obsesiva" },
	{ name: "Histérica" },
	{ name: "Fobia" },
	{ name: "Border" },
	{ name: "Psicosis" },
	{ name: "Sin especificar" }
]

puts "--- Poblando catálogo de Estructura Clinica (#{clinical_structure_entries.count} inserciones)... "
clinical_structure_created = ClinicalStructureType.create(clinical_structure_entries)
puts "   #{ClinicalStructureType.all.count} inserciones hechas al catálogo de Estructura Clinica."

# -----> CATALOGO SIGNOS Y SINTOMAS <-----

SymptomType.delete_all
symptom_entries = [
	{ name: "Agresividad" },
	{ name: "Aislamiento" },
	{ name: "Alcoholismo" },
	{ name: "Alucinaciones" },
	{ name: "Ansiedad y Estrés" },
	{ name: "Ataque de pánico" },
	{ name: "Atracones" },
	{ name: "Auto sabotaje" },
	{ name: "Autolesiones" },
	{ name: "Autorreproches" },
	{ name: "Celos" },
	{ name: "Confusión" },
	{ name: "Culpa" },
	{ name: "Dependencia" },
	{ name: "Desesperación" },
	{ name: "Desesperanza" },
	{ name: "Desinterés" },
	{ name: "Dificultad adaptación" },
	{ name: "Dificultad para estudiar" },
	{ name: "Enojo" },
	{ name: "Envidia" },
	{ name: "Exigencias elevadas" },
	{ name: "Falta de apetito" },
	{ name: "Flojera" },
	{ name: "Fobias" },
	{ name: "Hiperactividad" },
	{ name: "Hipocondría" },
	{ name: "Ideación suicida" },
	{ name: "Ideas obsesivas" },
	{ name: "Ideas paranoides" },
	{ name: "Identidad sexual" },
	{ name: "Inestabilidad emocional" },
	{ name: "Insatisfacción" },
	{ name: "Insomnio" },
	{ name: "Intento de suicidio" },
	{ name: "Miedo a participar" },
	{ name: "Preocupación calorías" },
	{ name: "Problemas de autoestima" },
	{ name: "Problemas para relacionarse" },
	{ name: "Rituales" },
	{ name: "Soledad" },
	{ name: "Somatización" },
	{ name: "Taquicardia" },
	{ name: "Tristeza" },
	{ name: "Vómito" },
	{ name: "Sin especificar" }
]

puts "--- Poblando catálogo de Signos y Síntomas (#{symptom_entries.count} inserciones)... "
symptom_created = SymptomType.create(symptom_entries)
puts "   #{SymptomType.all.count} inserciones hechas al catálogo de Signos y Síntomas."
