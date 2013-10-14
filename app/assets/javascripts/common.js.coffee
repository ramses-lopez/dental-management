#Archivo para funciones reutilizables

#Las funciones que estan definidas con un @ delante se vinculan con el objeto window,
#haciendolas disponibles en todo el sitio (una funcion global, basicamente)

#Construye un string de atributos data, acepta un arreglo opcional de excepciones
@buildDataAttr = (data, exceptions...) ->
	dataString = ''
	for own attr, value of data
		dataString += "data-#{attr}='#{value}' " unless attr in exceptions
	dataString

#metodos para agregar/eliminar nested_attributes
$(document).on 'click', 'a.remove_fields', (event) ->
	$(this).siblings('input[type=hidden]').val('1')
	$(this).closest('.invoice_item').hide()
	event.preventDefault()

$(document).on 'click', 'a.add_fields', (event) ->
	time = new Date().getTime()
	regexp = new RegExp($(this).data('id'), 'g')
	form_fields = $(this).data('fields').replace(regexp, time)
	$($(this).data('container')).append(form_fields)
	event.preventDefault()

#funcionalidad para agregar/eliminar nested_attributes a partir de un select
#por ejemplo, beneficiarios a una cuenta
$(document).on 'change', 'select.add_fields', (event) ->
	models_on_page = $('.field_container')
	models_requested = $(this).val()
	models_to_render = models_requested - models_on_page.size()

	if models_requested == 'No' || models_requested == '0'
		models_on_page.remove()
	else if models_to_render < 0
		models_on_page.slice(models_to_render).remove()
	else
		models_on_page.remove()
		model_index = models_requested

		for i in [1..models_requested] by 1
			regexp = new RegExp($(this).data('id'), 'g')
			fields = $(this).data('fields').replace(regexp, new Date().getTime())
			counter = new RegExp('field_container_counter', 'g')
			fields = fields.replace(counter, model_index)
			$(this).after(fields)
			model_index -= 1

	event.preventDefault()
