totalize_invoice = ->

	subtotal = 0
	tax = 0.12

	$('.invoice_item').each ->
		quantity = $(this).find('.quantity').first().val()
		price = $(this).find('.item_price').first().val()

		if quantity != '' && price != ''
			subtotal += quantity * price

	$('#subtotal').text(subtotal)
	$('#tax').text(subtotal * tax)
	$('#total').text(subtotal * (1+tax))

$(document).on 'change', '.quantity', ->
	totalize_invoice()

$(document).on 'change', '.item_price', ->
	totalize_invoice()