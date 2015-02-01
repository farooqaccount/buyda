# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    
height = window.innerHeight - 49
$("#main").css("min-height", height).on("click", ".expand-link", (e) ->
  body = $("body")
  e.preventDefault()
  box = $(this).closest("div.box")
  button = $(this).find("i")
  button.toggleClass("fa-expand").toggleClass "fa-compress"
  box.toggleClass "expanded"
  body.toggleClass "body-expanded"
  timeout = 0
  timeout = 100  if body.hasClass("body-expanded")
  setTimeout (->
    box.toggleClass "expanded-padding"
    return
  ), timeout
  setTimeout (->
    box.resize()
    box.find("[id^=map-]").resize()
    return
  ), timeout + 50
  return
).on("click", ".collapse-link", (e) ->
  e.preventDefault()
  box = $(this).closest("div.box")
  button = $(this).find("i")
  content = box.find("div.box-content")
  content.slideToggle "fast"
  button.toggleClass("fa-chevron-up").toggleClass "fa-chevron-down"
  setTimeout (->
    box.resize()
    box.find("[id^=map-]").resize()
    return
  ), 50
  return
).on "click", ".close-link", (e) ->
  e.preventDefault()
  content = $(this).closest("div.box")
  content.remove()
  return

$("#locked-screen").on "click", (e) ->
  e.preventDefault()
  $("body").addClass "body-screensaver"
  $("#screensaver").addClass "show"
  ScreenSaver()
  return

$("body").on "click", "a.close-link", (e) ->
  e.preventDefault()
  CloseModalBox()
  return

$("#top-panel").on "click", "a", (e) ->
  if $(this).hasClass("ajax-link")
    e.preventDefault()
    if $(this).hasClass("add-full")
      $("#content").addClass "full-content"
    else
      $("#content").removeClass "full-content"
    url = $(this).attr("href")
    window.location.hash = url
    LoadAjaxContent url
  return

$("#search").on "keydown", (e) ->
  if e.keyCode is 13
    e.preventDefault()
    $("#content").removeClass "full-content"
    ajax_url = "ajax/page_search.html"
    window.location.hash = ajax_url
    LoadAjaxContent ajax_url
  return

$("#screen_unlock").on "mouseover", ->
  header = "Enter current username and password"
  form = $("<div class=\"form-group\"><label class=\"control-label\">Username</label><input type=\"text\" class=\"form-control\" name=\"username\" /></div>" + "<div class=\"form-group\"><label class=\"control-label\">Password</label><input type=\"password\" class=\"form-control\" name=\"password\" /></div>")
  button = $("<div class=\"text-center\"><a href=\"index.html\" class=\"btn btn-primary\">Unlock</a></div>")
  OpenModalBox header, form, button
  return

#
#  Helper for open ModalBox with requested header, content and bottom
#
#
OpenModalBox = (header, inner, bottom) ->
  modalbox = $("#modalbox")
  modalbox.find(".modal-header-name span").html header
  modalbox.find(".devoops-modal-inner").html inner
  modalbox.find(".devoops-modal-bottom").html bottom
  modalbox.fadeIn "fast"
  $("body").addClass "body-expanded"
  return

#
#  Close modalbox
#
#
CloseModalBox = ->
  modalbox = $("#modalbox")
  modalbox.fadeOut "fast", ->
    modalbox.find(".modal-header-name span").children().remove()
    modalbox.find(".devoops-modal-inner").children().remove()
    modalbox.find(".devoops-modal-bottom").children().remove()
    $("body").removeClass "body-expanded"
    return

  return
 
