// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require best_in_place
//= require best_in_place.purr
//= require jquery.turbolinks
//= require jquery_ujs
//= require twitter/bootstrap
//= require dataTables/jquery.dataTables
//= require jquery_nested_form
//= require jquery-ui
//= require jquery.datetimepicker
//= require jquery.tokeninput
//= require jquery-calx-1.1.9.min
//= require turbolinks
//= require social-share-button
//= require_tree .


$(function() {
    
  $("#coupon_product_tokens").tokenInput("/products.json", {
    crossDomain: false,
    prePopulate: $("#coupon_product_tokens").data("pre"),
    theme: "facebook"
  });
   
  $("#coupon_manufacturer_tokens").tokenInput("/manufacturers.json", {
    crossDomain: false,
    prePopulate: $("#coupon_manufacturer_tokens").data("pre"),
    theme: "facebook"
  });
    $("#coupon_category_tokens").tokenInput("/categories.json", {
    crossDomain: false,
    prePopulate: $("#coupon_category_tokens").data("pre"),
    theme: "facebook"
  });
    
    $("#review_product_token").tokenInput("/products.json", {
    crossDomain: false,
    tokenLimit: 1,
    prePopulate: $("#review_product_token").data("pre"),
    theme: "facebook"
  });
});


