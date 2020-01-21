function copy_token() {
  var copyText = document.getElementById("api-token");
  copyText.select();
  document.execCommand("copy");
}

