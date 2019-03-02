import Vue from 'vue/dist/vue.esm'
import TaskList from '../../components/task-list'

$(function() {
  return new Vue({
    el: '#app',

    components: {
      TaskList
    }
  });
});
