$(document).on('ready page:load', function(){
  $('#user_phone_number').inputmask({mask: '(999)999-9999'});

  $('#window-modal, #window-modal-small').on('show.bs.modal', function(){

  })

  $('#window-modal, #window-modal-small').on('hidden.bs.modal', function(){
  	$(this).removeData('bs.modal');
  })
});

openModal = function(link){
	named = "#window-modal";
  $(named).modal({remote: link});
}

openModalSmall = function(link){
	named = "#window-modal-small";
  $(named).modal({remote: link});	
}