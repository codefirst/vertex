<template lang="pug">
.task-list
  draggable.table-sortable(tag='ul' v-model='tasks' @end='onSortEnd')
    task(v-for='task in tasks' :key='task.id' :task='task' @deleted='deleted')
  a.new-task(href='#' @click='addTask')
    | New Task

</template>

<script lang='ts'>
import {Vue, Component, Prop} from 'vue-property-decorator'
import axios from 'axios'
import Draggable from 'vuedraggable'
import Task from './task.vue'

@Component({
  components: {Draggable, Task}
})
export default class TaskList extends Vue {
  tasks: TaskData[] = []

  beforeMount() {
    axios.get('/tasks.json').then((response) => {
      this.tasks = response.data;
    });
  }

  mounted() {
    axios.defaults.headers.common['X-CSRF-TOKEN'] = document.getElementsByName("csrf-token")[0].getAttribute('content');
  }

  addTask() {
    axios.post('/tasks.json', { task: { title: 'New Task' } }).then(response => {
      var task = response.data;
      this.tasks.push(task);
    });
  }

  deleted(task) {
    console.log(task);
    this.tasks = this.tasks.filter(t => t.id !== task.id);
  }

  onSortEnd(originalEvent) {
    axios.put(`/tasks/${this.tasks[originalEvent.newIndex].id}/sort`, { task: { row_order_position: originalEvent.newIndex } });
  }
}
</script>

<style lang="scss" scoped>
.table-sortable {
  list-style-type: none;
  padding-left: 0px;
}
</style>
