$ ->
  $('.task-checkbox').on('change', (e) ->
    $.ajax({
      url: '/tasks/' + this.value + '.json',
      type: 'PUT',
      data: {"task": {"done": this.checked}}
    })
  )
