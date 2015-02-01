# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $('#products').dataTable()
    
    $("#manufaturing-date").datepicker(
        #format: "d M Y"
        altField: "#manufactuering-date-alt",
        altFormat: "yy-mm-d"
    )

    $('#datetimepicker').datetimepicker({
        format:'Y-m-d H:i',
        closeOnDateSelect:true
        }
    );
       
    
    $('#image_button').click ->
      $('#datetimepicker').datetimepicker('show')
    



    
