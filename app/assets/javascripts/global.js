$(document).on('ready page:load', function(){
  $('#user_phone_number').inputmask({mask: '(999)999-9999'});

  $('#window-modal, #window-modal-small').on('show.bs.modal', function(){

  });

  $('#window-modal, #window-modal-small').on('hidden.bs.modal', function(){
  	$(this).removeData('bs.modal');
  });

  setupTrading();
});

setupTrading = function(){
  price = $("#price").data("price");
  price = parseFloat(price);

  // $('#trade_usd_amount').inputmask({mask: '99999999999'});
  // $('#trade_btc_amount').inputmask({mask: '99999999999'});
  $('#trade_phone_number').inputmask({mask: '(999)999-9999'});

  $("#trade_usd_amount").keyup(function(){
    usd = $(this).val();
    $("#trade_btc_amount").val(usd / price);
  });

  $("#trade_btc_amount").keyup(function(){
    btc = $(this).val();
    console.log(price);
    $("#trade_usd_amount").val(btc * price);
  })
}

openModal = function(link){
	named = "#window-modal";
  $(named).modal({remote: link});
}

openModalSmall = function(link){
	named = "#window-modal-small";
  $(named).modal({remote: link});	
}