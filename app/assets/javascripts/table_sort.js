/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
$(() =>
    $('.table-sortable').sortable({
        axis: 'y',
        items: '.item',

        update(e, ui) {
            const { item } = ui;
            const item_data = item.data();
            const params = { _method: 'put' };
            params[item_data.model_name] = { row_order_position: item.index() };
            return $.ajax({
                type: 'POST',
                url: item_data.update_url,
                dataType: 'json',
                data: params
            });
        },
        stop(e, ui) {
            return ui.item.effect('highlight');
        }
    })
);