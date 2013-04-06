# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  if (!$('.guides, .welcome, .m_welcome, .m_guides').is(':visible'))
    $('#search').autocomplete
      source: "/class_room_for_years"
      select: (event, ui) ->
        window.location.href = "/class_room_for_years/" + ui.item.id
    .data( "ui-autocomplete" )._renderItem = ( ul, item ) ->
      return $( "<li>" ).append( "<a>" + item.label + "<br>" + item.teacher + "</a>" ).appendTo( ul );
