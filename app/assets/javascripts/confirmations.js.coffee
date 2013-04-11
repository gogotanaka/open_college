# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  school_subjects = $('#user_school_subject_id').html()
  console.log(school_subjects)
  $('#user_department_id').change ->
    department = $('#user_department_id :selected').text()
    options = $(school_subjects).filter("optgroup[label='#{department}']").html()
    console.log(options)
    if options
      $('#user_school_subject_id').html(options)
    else
      $('#user_school_subject_id').empty()