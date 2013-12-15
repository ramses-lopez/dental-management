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

	clear_and_reset('Item')
	Item.create!([
		{ label: "Abrebocas"},
		{ label: "Abutment DIO"},
		{ label: "Abutment MIS"},
		{ label: "Aceite kavo"},
		{ label: "Ácido"},
		{ label: "Acrilico Líquido"},
		{ label: "Acrilico Polvo"},
		{ label: "Acrílico líquido"},
		{ label: "Agua oxigenada"},
		{ label: "Agujas cortas"},
		{ label: "Agujas de irrigación"},
		{ label: "Agujas largas"},
		{ label: "Alcohol de quemar"},
		{ label: "Alcohol isopropilico"},
		{ label: "Alginato"},
		{ label: "Algodon trenzado"},
		{ label: "Algodón"},
		{ label: "Ambientadores luz"},
		{ label: "Ambientadores spray"},
		{ label: "Anestesia al 2%"},
		{ label: "Anestesia al 3%"},
		{ label: "Anestesia al 4%"},
		{ label: "Aplicadores"},
		{ label: "Azucar"},
		{ label: "Baberos"},
		{ label: "Baja lenguas"},
		{ label: "Banda matriz"},
		{ label: "Bandas de celuloide"},
		{ label: "Batas quirúrgicas"},
		{ label: "Bisturi sin mango"},
		{ label: "Bisturí con mango"},
		{ label: "Blanqueamiento"},
		{ label: "Bolsas grandes"},
		{ label: "Bolsas pequeñas"},
		{ label: "Cafe"},
		{ label: "Campos quirúrgicos"},
		{ label: "Cds"},
		{ label: "Cemento de base autocurado"},
		{ label: "Cemento de base fotocurado"},
		{ label: "Cemento definitivo autocurado"},
		{ label: "Cemento definitivo fotocurado"},
		{ label: "Cemento reparador"},
		{ label: "Cepillos profilaxis"},
		{ label: "Cera Rodete"},
		{ label: "Cinta testigo"},
		{ label: "Cloro"},
		{ label: "Coltosol"},
		{ label: "Conos de papel"},
		{ label: "Cubetas para fluor"},
		{ label: "Cuñas de madera"},
		{ label: "Cánulas plásticas"},
		{ label: "Desensibilizante"},
		{ label: "Dientes acrilico"},
		{ label: "Duralay"},
		{ label: "EDTA"},
		{ label: "Endometazona"},
		{ label: "Envoplast"},
		{ label: "Esponjas"},
		{ label: "Estructure"},
		{ label: "Eyectores"},
		{ label: "Fijador"},
		{ label: "Fijador Rx"},
		{ label: "Fluor"},
		{ label: "Fresa sacabocado"},
		{ label: "Fresas"},
		{ label: "Fundas de Cds"},
		{ label: "Gasas"},
		{ label: "Gel hemostatico"},
		{ label: "Gelatamp"},
		{ label: "Gerdex"},
		{ label: "Gorros doctores"},
		{ label: "Gorros unidades"},
		{ label: "Grapas"},
		{ label: "Grapas de Endodoncia"},
		{ label: "Guantes M"},
		{ label: "Guantes quirúrgicos talla L"},
		{ label: "Guantes quirúrgicos talla M"},
		{ label: "Guantes quirúrgicos talla S"},
		{ label: "Guantes S"},
		{ label: "Guantes XS"},
		{ label: "Gutapercha"},
		{ label: "Hidróxido de Calcio"},
		{ label: "Hidróxido de Calcio caralizador/base"},
		{ label: "Hilo Retractor"},
		{ label: "Hipoclorito"},
		{ label: "Hueso bovino"},
		{ label: "Hueso humano"},
		{ label: "Hueso porcino"},
		{ label: "Implantes DIO"},
		{ label: "Implantes MIS"},
		{ label: "Jeringas grandes"},
		{ label: "Jeringas pequeñas"},
		{ label: "Laminas para férulas"},
		{ label: "Limas endodoncia"},
		{ label: "Manguera motor implantes"},
		{ label: "Mascarilla de oxigeno"},
		{ label: "Material Liviano"},
		{ label: "Material pesado"},
		{ label: "Mechas"},
		{ label: "Microbrush"},
		{ label: "Mini implantes"},
		{ label: "MTA"},
		{ label: "Papel de articular"},
		{ label: "Papel higiénico"},
		{ label: "Papel para esterilizar"},
		{ label: "Pasta Profilaxis"},
		{ label: "Piedra Pomez "},
		{ label: "Portacampos"},
		{ label: "Prymer"},
		{ label: "Puntas rotatorias doradas"},
		{ label: "Radiografías periapicales"},
		{ label: "Radiografías tomografo"},
		{ label: "Recolector de biopsias"},
		{ label: "Relix"},
		{ label: "Resina"},
		{ label: "Resina fluida"},
		{ label: "Revelador"},
		{ label: "Sealopex"},
		{ label: "Sellante"},
		{ label: "Separadores de minesotta"},
		{ label: "Servilletas"},
		{ label: "Solución fisiológica"},
		{ label: "Solvente de naranja"},
		{ label: "Sutura"},
		{ label: "Tapabocas"},
		{ label: "Te"},
		{ label: "Temp bond"},
		{ label: "Tiranervios"},
		{ label: "Tiras abrasivas de resina"},
		{ label: "Tiras abrasivas metálicas"},
		{ label: "Toallin"},
		{ label: "Tornillos"},
		{ label: "Vaselina"},
		{ label: "Vasos cónicos"},
		{ label: "Xylol"},
		{ label: "Yeso amarillo"},
		{ label: "Yeso ortodoncia"},
		{ label: "Yeso Rosado "},
	])





end