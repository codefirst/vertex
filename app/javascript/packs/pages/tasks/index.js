import Vue from 'vue/dist/vue.esm'
import TaskList from '../../components/task-list.vue'

$(function() {
  return new Vue({
    el: '#app',

    components: {
      TaskList
    }
  });
});
