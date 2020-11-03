<template>
  <div>
    <div id="spaceur-10"></div>
    <h1>ClockManager-id</h1>
    <h3>
      {{user.username}} <br>
      {{user.email}}
    </h3>
    <div id="spaceur-10"></div>

    <div class="list row">
      <div class="col-md-12 liste">
        <h4>Clocks List</h4>
        <ul class="list-group">
          <li class="list-group-item" :class="{ active: index == currentIndex }"
          v-for="(clock, index) in clocks" :key="index">
            {{ clock.time }}
          </li>
        </ul>
      </div>
    </div>
    <a class="badge badge-warning" :href="'/#/clock/add/' + user.id">
      Add
    </a>
  </div>
</template>

<script>
import ClockDataService from '../../services/ClockDataService'
import UserDataService from '../../services/UserDataService'

export default {
  name: 'Clock',
  data () {
    return {
      currentIndex: -1,
      clocks: [],
      user: [],
      message: ''
    }
  },
  methods: {
    retrieveClocks (id) {
      ClockDataService.get(id)
        .then(response => {
          this.clocks = response.data['data']
          console.log(response.data['data'])
        })
        .catch(e => {
          console.log(e)
        })
    },
    getUser (id) {
      UserDataService.get(id)
        .then(response => {
          this.user = response.data['data']
          console.log(response.data['data'])
        })
        .catch(e => {
          console.log(e)
        })
    }
  },
  mounted () {
    this.retrieveClocks(this.$route.params['id'])
    this.getUser(this.$route.params['id'])
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
