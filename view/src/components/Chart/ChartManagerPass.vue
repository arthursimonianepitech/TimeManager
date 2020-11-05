<template>
  <div>
    <div id="spaceur-10"></div>
    <h1>workingtimeManager</h1>
    <div id="spaceur-10"></div>
    <!-- ***************************** -->
    <!-- ************ User *********** -->
    <!-- ***************************** -->
    <div class="list row">
      <div class="col-md-6">
        <h4>Users List</h4>
        <ul class="list-group">
          <li class="list-group-item" :class="{ active: indexUser == currentIndexUser }"
          v-for="(user, indexUser) in users" :key="indexUser"
          @click="setActiveUser(user, indexUser)">
            {{ user.email }}
          </li>
        </ul>
      </div>
      <div class="col-md-6">
        <div v-if="currentUser">
          <h4>user</h4>
          <div>
            <label><strong>username:</strong></label> {{ currentUser.username }}
          </div>
          <div>
            <label><strong>email:</strong></label> {{ currentUser.email }}
          </div>
          <a class="badge badge-warning" :href="'/#/ChartManager/' + currentUser.id">
            Chart
          </a>
        </div>
        <div v-else>
          <br />
          <p>Please click on a user...</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import UserDataService from '../../services/UserDataService'

export default {
  name: 'chartmanagerpass',
  data () {
    return {
      users: [],
      currentUser: null,
      currentIndexUser: -1
    }
  },
  methods: {
    onInitFirst () {
      if (localStorage.getItem("connect") != "true") {
        window.location.href = "/#/login"
      }
    },
    // *******************************************
    // User
    // *******************************************
    retrieveUsers () {
      UserDataService.getAll()
        .then(response => {
          this.users = response.data['data']
          console.log(response.data['data'])
        })
        .catch(e => {
          console.log(e)
        })
    },
    refreshListUser () {
      this.retrieveUsers()
      this.currentUser = null
      this.currentIndexUser = -1
    },
    setActiveUser (user, indexUser) {
      this.currentUser = user
      this.currentIndexUser = indexUser
    }
  },
  mounted () {
    this.onInitFirst()
    this.retrieveUsers()
  }
}
</script>

<!-- Add 'scoped' attribute to limit CSS to this component only -->
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
