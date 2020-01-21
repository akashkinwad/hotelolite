$(function() {

});

function plansList(params) {
  $.ajax({
    type: "GET",
    url: "/plans/available_monthly_yearly",
    data: { monthly_yearly: params },
    success: function(data, textStatus, jqXHR){
    },
    error: function(jqXHR, textStatus, errorThrown){
    }
  })
}
