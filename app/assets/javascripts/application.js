// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require bootstrap
//= require elemental
//= require elemental-reload
//= require elemental-javascript_enabled
//= require jquery
//= require jquery_ujs
//= require select2
//= require underscore
//= require_tree .

$(function() {
  Elemental.load($(document));
});


searchInitializer = function(element) {
  $("#search_button").on("click", searchArticles);
}

searchArticles = function(element) {
  var keywords = $("#search_box").val();
  var dataObj = { keywords: keywords }

  window.location.href = "/searches/?keywords=" + dataObj.keywords

  // $.ajax({
    // url: "/searches",
    // data: dataObj,
    // method: "GET"
  // });
}
