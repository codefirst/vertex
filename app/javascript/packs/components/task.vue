<template lang="pug">
li.item(data-task-id="task.id")
  span.task-done
    input(type='checkbox' @change='toggleDone' v-model='task.done')
  span.task-title
    input(v-if='isEdit' type='text' v-model='task.title' @keyup.enter='keyupEnter' @blur='toggleEdit(task)' ref='input')
    span(v-else @click='toggleEdit(task)')
      | {{task.title}}
  span.task-delete(@click='deleteTask(task)')
    a.fa.fa-trash
</template>

<script lang='ts'>
import {Vue, Component, Prop, Emit} from 'vue-property-decorator'
import axios from 'axios'

@Component
export default class Task extends Vue {
  @Prop({ default: () => ({}) })  readonly task!: TaskData

  isEdit: boolean = false;

  toggleDone() {
    axios.put(`/tasks/${this.task.id}.json`, { task: { done: this.task.done } });
  }

  @Emit('deleted')
  emitDeleted() {
    return this.task;
  }

  deleteTask() {
    axios.delete(`/tasks/${this.task.id}.json`).then(response => {
      this.emitDeleted();
    });
  }

  toggleEdit(task: TaskData) {
    this.isEdit = !this.isEdit;

    this.$nextTick(() => {
      if (this.isEdit) {
        (this.$refs.input as HTMLElement).focus();
      } else {
        axios.put(`/tasks/${task.id}.json`, { task: { title: task.title } });
      }
    });
  }

  keyupEnter() {
    (this.$refs.input as HTMLElement).blur();
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
