<template>
  <div>
    <div id="spaceur-10"></div>
      <h1>WorkingTimeManager-userid</h1>
      <h3>
        {{user.username}} <br>
        {{user.email}}
      </h3>
    <div id="spaceur-10"></div>

    <div class="list row">
      <div class="col-md-12 liste">
        <h4>Workingtimes List</h4>
        <ul class="list-group">
          <li class="list-group-item" :class="{ active: index == currentIndex }"
          v-for="(workingtime, index) in workingtimes" :key="index">
            {{ workingtime.start }} . {{ workingtime.end }}
          </li>
        </ul>
      </div>
    </div>
    <a class="badge badge-warning" :href="'/#/workingtime/add/' + user.id">
      Add
    </a>
  </div>
</template>

<script>
import WorkingTimeDataService from '../../services/WorkingTimeDataService'
import UserDataService from '../../services/UserDataService'

export default {
  name: 'WorkingTime',
  data () {
    return {
      currentIndex: -1,
      workingtimes: [],
      user: [],
      message: ''
    }
  },
  methods: {
    onInitFirst () {
      if (localStorage.getItem("connect") != "true") {
        window.location.href = "/#/login"
      }
    },
    retrieveWorkingtimes (id) {
      WorkingTimeDataService.get(id)
        .then(response => {
          this.workingtimes = response.data['data']
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
    this.onInitFirst()
    this.retrieveWorkingtimes(this.$route.params['id'])
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
