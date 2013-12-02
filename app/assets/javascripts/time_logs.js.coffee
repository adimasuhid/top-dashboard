main = ->
  $(".informed").on "click", (e)->
    id = $(e.target).parents("tr").attr("id")
    val = $(e.target).hasClass("fa-square")
    $.ajax({
      type: "PUT"
      url: "/time_logs/#{id}/ajax_update"
      data: {time_log: {parent_informed: val}}
      success: ->
        toggleClass(e.target, ["fa-square", "fa-check-square"])
    })

  $(".tutor_paid").on "click", (e)->
    id = $(e.target).parents("tr").attr("id")
    val = $(e.target).hasClass("fa-square")
    $.ajax({
      type: "PUT"
      url: "/time_logs/#{id}/ajax_update"
      data: {time_log: {tutor_paid: val}}
      success: ->
        toggleClass(e.target, ["fa-square", "fa-check-square"])
    })

  $(".parent_paid").on "click", (e)->
    id = $(e.target).parents("tr").attr("id")
    val = $(e.target).hasClass("fa-square")
    $.ajax({
      type: "PUT"
      url: "/time_logs/#{id}/ajax_update"
      data: {time_log: {parent_paid: val}}
      success: ->
        toggleClass(e.target, ["fa-square", "fa-check-square"])
    })

  toggleClass = (target, class_array)->
    if $(target).hasClass(class_array[0])
      $(target).removeClass(class_array[0])
      $(target).addClass(class_array[1])
    else
      $(target).removeClass(class_array[1])
      $(target).addClass(class_array[0])

$(document).on "page:load", main
$(document).ready(main)
