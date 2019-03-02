/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
$(function() {
  $(document).on('change', '.task-checkbox', function(e) {
    return $.ajax({
      url: `/tasks/${this.value}.json`,
      type: 'PUT',
      data: {"task": {"done": this.checked}}
    });
  });

  $('.new-task').on('click', e =>
    $.ajax({
      url: '/tasks.json',
      type: 'POST',
      data: {"task": {"title": 'New Task'}}
    }).done((data, dataType) => $('.task-list').append(liTag(data['id'], data['title'])))
  );

  var liTag = function(id, title) {
    const li = $('<li>');
    li.attr('class', 'item ui-sortable-handle');
    li.attr('data-model-name', 'task');
    li.attr('data-update-url', `/tasks/${id}/sort`);
    li.append(doneCheckboxTag(id));
    li.append(titleTag(id, title));
    return li.append(deleteTag(id));
  };

  var doneCheckboxTag = function(id) {
    const spanTag = $('<span>');
    spanTag.attr('class', 'task-done');
    const checkboxTag = $('<input>');
    checkboxTag.attr('class', 'task-checkbox');
    checkboxTag.attr('id', `tasks_${id}`);
    checkboxTag.attr('name', `tasks[${id}]`);
    checkboxTag.attr('value', id);
    checkboxTag.attr('type', 'checkbox');
    return spanTag.append(checkboxTag);
  };

  var titleTag = function(id, title) {
    const spanTag = $('<span>');
    spanTag.attr('class', 'task-title');
    const textTag = $('<span>');
    textTag.attr('id', `best_in_place_task_${id}_title`);
    textTag.attr('class', 'best_in_place');
    textTag.attr('data-bip-attribute', 'title');
    textTag.attr('data-bip-object', 'task');
    textTag.attr('data-bip-original-content', title);
    textTag.attr('data-bip-placeholder', title);
    textTag.attr('data-bip-type', 'input');
    textTag.attr('data-bip-url', `/tasks/${id}`);
    textTag.attr('data-bip-value', title);
    textTag.text(title);
    return spanTag.append(textTag);
  };

  var deleteTag = function(id) {
    const spanTag = $('<span>');
    spanTag.attr('class', 'task-delete');
    const aTag = $('<a>');
    aTag.attr('data-confirm', 'Are you sure?');
    aTag.attr('data-task-id', id);
    aTag.attr('href', '#');
    aTag.attr('rel', 'nofollow');
    spanTag.append(aTag);
    const iTag = $('<i>');
    iTag.attr('class', 'fa fa-trash');
    aTag.append(iTag);
    return spanTag;
  };

  return $(document).on('confirm:complete', '.task-delete > a', function(e, answer) {
    if (answer) {
      const id = $(e.target).attr('data-task-id');
      return $.ajax({
        url: `/tasks/${id}.json`,
        type: 'DELETE',
      }).done((data, dataType) => $(e.target).parent().parent().remove());
    }
  });
});

