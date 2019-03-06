<template lang="pug">
li.item(data-task-id="task.id")
  span.task-done
    input(type='checkbox' @change='toggleDone' v-model='task.done')
  span.task-title
    input(v-if='isEdit' type='text' v-model='task.title' @blur='toggleEdit(task)' ref='input')
    span(v-else @click='toggleEdit(task)')
      | {{task.title}}
  span.task-delete(@click='deleteTask(task)')
    a.fa.fa-trash
</template>

<script>
import axios from 'axios'

export default {
  name: 'Task',

  props: {
    task: { type: Object }
  },

  data() {
    return {
      isEdit: false
    }
  },

  methods: {
    toggleDone() {
      axios.put(`/tasks/${this.task.id}.json`, { task: { done: this.task.done } });
    },

    deleteTask() {
      axios.delete(`/tasks/${this.task.id}.json`).then(response => {
        this.$emit('deleted', this.task);
      });
    },

    toggleEdit(task) {
      this.isEdit = !this.isEdit;

      this.$nextTick(() => {
        if (this.isEdit) {
          this.$refs.input.focus();
        } else {
          axios.put(`/tasks/${task.id}.json`, { task: { title: task.title } });
        }
      });
    },
  }
}
</script>

<style lang="scss" scoped>
.task-done {
  padding-left: 0px;
}
.task-title {
  padding-left: 4px;
}
.task-delete {
  padding-left: 8px;
}

li.item {
  cursor: row-resize;
}
li.item.sortable-ghost {
  visibility: hidden;
}
</style>
