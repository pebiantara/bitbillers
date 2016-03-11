$(document).on('ready page:load', function(){
  $('#user_phone_number').inputmask({mask: '(999)999-9999'});

  $('#window-modal, #window-modal-small').on('show.bs.modal', function(){
    copyClipboard();
  });

  $('#window-modal, #window-modal-small').on('hidden.bs.modal', function(){
  	$(this).removeData('bs.modal');
    $(this).find(".modal-content").html('');
  });

  setupTrading();
  setInterval(function(){
    $.ajax({
      url: "/markets",
      dataType: "json",
      success: function(data){
        $.each(data, function(i, val){
          if(i == "updated_at")
            $("."+i).html(val);
          else
            $("."+i).html("$" + val);
        })

        $("#price").data('price', data.price).html("$"+data.price+"/1BTC");
        price = $("#price").data("price");
        $("#trade_btc_amount").val($("#trade_usd_amount").val() / price);
        $("#trade_exchange_rate").val(data.price);
      }
    })
  }, 2000);
});

copyClipboard = function(){
  var btc_cp = new Clipboard('#cp-btc-amount');

  var wallet_cp = new Clipboard('#cp-wallet');
}

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