# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def clear_and_reset(classname)
	classname.classify.constantize.destroy_all
	ActiveRecord::Base.connection.reset_pk_sequence!(classname.tableize)
end

ActiveRecord::Base.transaction do

	clear_and_reset('Role')
	Role.create!([
		{ name: "administrador"},
		{ name: "manager"}
		])

	clear_and_reset('Provider')
	Provider.create!([
		{label: 'Proveedor desconocido'}
		])

	clear_and_reset('Item')
	Item.create!([
		{label: "Abreboca"},
		{label: "Abutment DIO"},
		{label: "Abutment MIS"},
		{label: "Aceite turbina "},
		{label: "Acrilico Líquido"},
		{label: "Acrilico rosado"},
		{label: "Acrílico color 69"},
		{label: "Acrílico de coronas y puentes"},
		{label: "Acrílico transparente"},
		{label: "Adhesivos"},
		{label: "Agua oxigenada"},
		{label: "Agujas cortas"},
		{label: "Agujas de irrigacion"},
		{label: "Agujas largas"},
		{label: "Alcohol de quemar"},
		{label: "Alcohol isopropilico"},
		{label: "Alginato"},
		{label: "Algodon trenzado"},
		{label: "Algodón"},
		{label: "Ambientadores luz"},
		{label: "Ambientadores spray"},
		{label: "Anestesia al 2%"},
		{label: "Anestesia al 3%"},
		{label: "Anestesia al 4%"},
		{label: "Anestesia tópica"},
		{label: "Aplicadores"},
		{label: "Azucar"},
		{label: "Baberos"},
		{label: "Baja Lenguas"},
		{label: "Banda matriz"},
		{label: "Bandas de celuloide"},
		{label: "bandas metálicas"},
		{label: "barniz de contacto prolongado"},
		{label: "Batas quirúrgicas"},
		{label: "Bisturi sin mango"},
		{label: "Bisturí con mango"},
		{label: "Blanqueamiento"},
		{label: "Bolsas grandes"},
		{label: "Bolsas pequeñas"},
		{label: "Bolsas QX"},
		{label: "Cafe"},
		{label: "Campos quirúrgicos"},
		{label: "Cds"},
		{label: "Cemento de base autocurado (capsula)"},
		{label: "Cemento de base fotocurado"},
		{label: "Cemento definitivo autocurado"},
		{label: "Cemento definitivo fotocurado"},
		{label: "Cemento reparador"},
		{label: "Cepillos profilaxis"},
		{label: "Cera Rodete"},
		{label: "Cinta testigo"},
		{label: "Cloro"},
		{label: "Coltosol"},
		{label: "Compuesto de alta fluidez con flúor"},
		{label: "Conos de papel # 15"},
		{label: "Conos de papel # 20"},
		{label: "Conos de papel # 25"},
		{label: "Conos de papel # 30"},
		{label: "Conos de papel # 35"},
		{label: "Conos de papel # 40"},
		{label: "Conos de papel # 45-80"},
		{label: "Cubetas para fluor"},
		{label: "Cuñas de madera"},
		{label: "Cánulas de succión"},
		{label: "Desensibilizante"},
		{label: "Desinfectante al frío"},
		{label: "Dientes acrilico"},
		{label: "Duralay"},
		{label: "Dycal (pasta)"},
		{label: "EDTA"},
		{label: "Endometazona"},
		{label: "Envoplast"},
		{label: "Esponjas"},
		{label: "Estructure"},
		{label: "Eugenol"},
		{label: "Eyectores"},
		{label: "Fijador Rx"},
		{label: "Fluor"},
		{label: "Fresa sacabocado"},
		{label: "Fresas"},
		{label: "Cds (Fundas)"},
		{label: "Gasas"},
		{label: "Gates # 2"},
		{label: "Gates # 3"},
		{label: "Gates # 4"},
		{label: "Gelatamp"},
		{label: "Gerdex"},
		{label: "Gorros doctores"},
		{label: "Gorros unidades"},
		{label: "Grapas de Endodoncia"},
		{label: "Guantes M"},
		{label: "Guantes quirúrgicos Dr Betancourt"},
		{label: "Guantes quirúrgicos Dr Correa"},
		{label: "Guantes quirúrgicos talla M"},
		{label: "Guantes S"},
		{label: "Guantes S Dra Rosmary"},
		{label: "Gutapercha # 25 0,06"},
		{label: "Gutapercha # 30 0,06"},
		{label: "Gutapercha # 35 0,06"},
		{label: "Gutapercha # 36"},
		{label: "Gutapercha # 45"},
		{label: "Gutapercha F3"},
		{label: "Gutapercha MF"},
		{label: "Hemostatico liquido en jeringa"},
		{label: "hidroxido de calcio (metaposte)"},
		{label: "Hidróxido de Calcio"},
		{label: "Hidróxido de Calcio caralizador/base"},
		{label: "Hilo Retractor"},
		{label: "Hipoclorito"},
		{label: "hojillas de bisturí"},
		{label: "Hueso bovino"},
		{label: "Hueso humano"},
		{label: "Hueso porcino"},
		{label: "Implantes DIO"},
		{label: "Implantes MIS"},
		{label: "Jeringas grandes"},
		{label: "Jeringas Largas"},
		{label: "Jeringas Pequeñas"},
		{label: "Laminas para férulas"},
		{label: "Ligas intermaxilares"},
		{label: "Lima 2.5mm 015"},
		{label: "Lima 21mm 015-040"},
		{label: "Lima 21mm 45+80"},
		{label: "Lima 21mm 45-80"},
		{label: "Lima 25mm 00-20"},
		{label: "Lima 25mm 040"},
		{label: "Lima 25mm 15-40"},
		{label: "Lima 25mm 45+80 "},
		{label: "Lima 25mm 45-80"},
		{label: "Limas endodoncia"},
		{label: "Manguera motor implantes"},
		{label: "Mascarilla de oxigeno"},
		{label: "Material Liviano"},
		{label: "material Pesado"},
		{label: "Mechas"},
		{label: "Microbrush"},
		{label: "Microplus"},
		{label: "Mini implantes"},
		{label: "MTA"},
		{label: "Papel de articular"},
		{label: "Papel de esterilización"},
		{label: "Papel higiénico"},
		{label: "Pasta Profilaxis"},
		{label: "Piedra Pomez"},
		{label: "Pinza para retirar brackets"},
		{label: "Portacampos"},
		{label: "puntas de irrigación"},
		{label: "Puntas rotatorias doradas"},
		{label: "Radiografías periapicales"},
		{label: "Radiografías tomografo"},
		{label: "Recolector de biopsias"},
		{label: "Relix"},
		{label: "Resina"},
		{label: "Resina fluida"},
		{label: "Revelador"},
		{label: "Sealopex"},
		{label: "Sellante"},
		{label: "Separadores de minesotta"},
		{label: "Servilletas"},
		{label: "Solución fisiológica"},
		{label: "Solvente de naranja"},
		{label: "Sutura"},
		{label: "Tapabocas "},
		{label: "Te"},
		{label: "Temp bond"},
		{label: "Tiranervios"},
		{label: "Tiras abrasivas de resina"},
		{label: "Tiras abrasivas metálicas"},
		{label: "tiras de miller"},
		{label: "Toallin"},
		{label: "Tornillos"},
		{label: "Vaselina"},
		{label: "Vasos cónicos"},
		{label: "Vidrio"},
		{label: "Xylol"},
		{label: "Yeso amarillo"},
		{label: "Yeso ortodoncia"},
		{label: "Yeso Rosado"},
		{label: "Ácido"},
		])
end