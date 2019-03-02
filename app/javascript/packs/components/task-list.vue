<template lang="pug">
.task-list
  draggable.task-list.table-sortable(element='ul' v-model='tasks' @end='onSortEnd')
    li.item(v-for='task in tasks' :key='task.id' data-task-id="task.id")
      span.task-done
        input(type='checkbox' @change='toggleDone(task)' v-model='task.done')
      span.task-title
        template(v-if='isEdit(task)')
          input(type='text' v-model='task.title' @blur='toggleEdit(task)' :ref='`title_${task.id}`')
        template(v-else)
          span(@click='toggleEdit(task)')
            | {{task.title}}
      span.task-delete(@click='deleteTask(task)')
        a.fa.fa-trash
  a.new-task(href='#' @click='addTask')
    | New Task

</template>

<script>
import axios from 'axios'
import Draggable from 'vuedraggable'

export default {
  name: 'TaskList',

  components: {
    Draggable
  },

  data() {
    return {
      tasks: []
    }
  },

  mounted() {
    axios.get('/tasks.json').then((response) => {
      this.tasks = response.data.map(task => {
        task.isEdit = false;
        return task;
      });
    });

    axios.defaults.headers.common['X-CSRF-TOKEN'] = document.getElementsByName("csrf-token")[0].getAttribute('content');
  },

  methods: {
    toggleDone(task) {
      axios.put(`/tasks/${task.id}.json`, { task: { done: task.done } });
    },

    deleteTask(task) {
      axios.delete(`/tasks/${task.id}.json`).then(response => {
        this.tasks = this.tasks.filter(t => t.id !== task.id);
      });
    },

    addTask() {
      axios.post('/tasks.json', { task: { title: 'New Task' } }).then(response => {
        this.tasks.push(response.data);
      });
    },

    toggleEdit(task) {
      task.isEdit = !task.isEdit;

      this.$nextTick(() => {
        if (task.isEdit) {
          this.$refs['title_' + task.id][0].focus();
        } else {
          axios.put(`/tasks/${task.id}.json`, { task: { title: task.title } });
        }
      });
    },

    isEdit(task) {
      return task.isEdit;
    },

    onSortEnd(originalEvent) {
      axios.put(`/tasks/${this.tasks[originalEvent.newIndex].id}/sort`, { task: { row_order_position: originalEvent.newIndex } });
    }
  }
}
</script>
