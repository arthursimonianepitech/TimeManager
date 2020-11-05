<template>
  <div>
    <div id="spaceur-10"></div>
    <h1>ClockManager</h1>
    <div id="spaceur-10"></div>
    <div class="list row">
      <div class="col-md-6">
        <h4>Users List</h4>
        <ul class="list-group">
          <li class="list-group-item" :class="{ active: index == currentIndex }"
          v-for="(user, index) in users" :key="index" @click="setActiveUser(user, index)">
            {{ user.email }}
          </li>
        </ul>
      </div>
      <div class="col-md-6">
        <div v-if="currentUser">
          <h4>User</h4>
          <div>
            <label><strong>email:</strong></label> {{ currentUser.email }}
          </div>
          <div>
            <label><strong>username:</strong></label> {{ currentUser.username }}
          </div>
          <a class="badge badge-warning" :href="'/#/clock/' + currentUser.id">
            Clock
          </a>
        </div>
        <div v-else>
          <br />
          <p>Please click on a User...</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import UserDataService from '../../services/UserDataService'

export default {
  name: 'Users-list',
  data () {
    return {
      users: [],
      currentUser: null,
      currentIndex: -1
    }
  },
  methods: {
    onInitFirst () {
      if (localStorage.getItem("connect") != "true") {
        window.location.href = "/#/login"
      }
    },
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

    refreshList () {
      this.retrieveUsers()
      this.currentUser = null
      this.currentIndex = -1
    },

    setActiveUser (User, index) {
      this.currentUser = User
      this.currentIndex = index
    }
  },
  mounted () {
    this.onInitFirst()
    this.retrieveUsers()
  }
}
</script>

<style>
.list {
  text-align: left;
  max-width: 750px;
  margin: auto;
}
#spaceur-10 {
  height: 10vh;
}
</style>
