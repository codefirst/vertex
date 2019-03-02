<template lang="pug">
.task-list
  ul.task-list.table-sortable
    li.item(v-for='task in tasks' :key='task.id')
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

export default {
  name: 'TaskList',

  data() {
    return {
      tasks: { type: Array, default: [] }
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
      axios.defaults.headers.common['X-CSRF-TOKEN'] = document.getElementsByName("csrf-token")[0].getAttribute('content');
      axios.delete(`/tasks/${task.id}.json`).then(response => {
        this.tasks = this.tasks.filter(t => t.id !== task.id);
      });
    },

    addTask() {
      axios.defaults.headers.common['X-CSRF-TOKEN'] = document.getElementsByName("csrf-token")[0].getAttribute('content');
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
          axios.defaults.headers.common['X-CSRF-TOKEN'] = document.getElementsByName("csrf-token")[0].getAttribute('content');
          axios.put(`/tasks/${task.id}.json`, { task: { title: task.title } });
        }
      });
    },

    isEdit(task) {
      return task.isEdit;
    }
  }
}
</script>
