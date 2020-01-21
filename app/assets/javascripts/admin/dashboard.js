$(function() {

});

function usersList(params) {
  $.ajax({
    type: "GET",
    url: "/admin/users/recently_joined",
    data: { joined: params },
    success: function(data, textStatus, jqXHR){
    },
    error: function(jqXHR, textStatus, errorThrown){
    }
  })
}
