# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $('.best_in_place').best_in_place()
    
    
    
    $(".best_in_place").on 'blur', (event, data, status, xhr) ->
    #alert("Best in place bind")
    $(this).find("input").keyup (e) ->
        alert("Text area")
        $textarea = $(this)
        if e.keyCode is 13 and not e.shiftKey
          e.preventDefault() # Don't make a new line
          # This line does weird things
          $(this).parents(".best_in_place").trigger("best_in_place:update").trigger "best_in_place:deactivate"
    return

  return
    
     #$('.best_in_place').live 'ajax:success', (event, data, status, xhr) ->
     #alert("Got a callback!")
   
    
#      $('.quantity').on 'ajax:success', (event, data, status, xhr) ->
#     newValue = $('.quantity').html
#     alert newValue
        
#     $(document).on "blur", ".quantity", ->
#         alert('quantity updated '+$(this).data('quantity'))
#         #alert('quantity updated '+$('.quan').html())
#       return
        
       