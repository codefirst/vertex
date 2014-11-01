$ ->
  $('.task-checkbox').bind('change', (e) ->
    $.ajax({
      url: '/tasks/' + this.value,
      type: 'PUT',
      data: {"task": {"done": (this.checked ? true : false)}}
    })
  )
