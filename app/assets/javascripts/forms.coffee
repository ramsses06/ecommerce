$(document).on "ajax:beforeSend", "#subscription-form", ()->
	$("#subscription-label").html "Procesando Petición"

$(document).on "ajax:success", "#subscription-form", (e,data,estado,xhr)->
	$("#subscription-label").html '<div class="alert alert-dismissible alert-success"><button type="button" class="close" data-dismiss="alert">×</button><strong>Gracias por Suscribirte.</strong> </div>'
	$(this).slideUp()

$(document).on "ajax:error", "#subscription-form", (e,data,estado,xhr) ->
	$("#subscription-label").html '<div class="alert alert-dismissible alert-danger"><button type="button" class="close" data-dismiss="alert">×</button><strong>Wooops!</strong> Algo salio mal. <div> * ' + data.responseJSON.email[0] + '</div></div>'