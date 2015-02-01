# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#property_zone_id").parent().hide()
    states = $("#property_zone_id").html()
    #alert(states)
    $("#property_country_id").change ->
    country = $("#property_country_id :selected").text()
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, "\\$1")
    options = $(states).filter("optgroup[label='#{escaped_country}']").html()
    console.log(options)
    if options
        $("#property_zone_id").html(options)
        $("#property_zone_id").parent().show()
    else
        $("#property_zone_id").empty()
        $("#property_zone_id").parent().hide()
