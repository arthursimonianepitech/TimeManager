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
          <a class="badge badge-warning" :href="'/#/workingtime/user/' + currentUser.id">
            WorkingTime
          </a>
        </div>
        <div v-else>
          <br />
          <p>Please click on a user...</p>
        </div>
      </div>
    </div>
    <div id="spaceur-10"></div>
    <!-- ***************************** -->
    <!-- ******** WorkingTime ******** -->
    <!-- ***************************** -->
    <div class="list row">
      <div class="col-md-6">
        <h4>Workingtimes List</h4>
        <ul class="list-group">
          <li class="list-group-item" :class="{ active: indexWorkingTime == currentIndexWorkingTime }"
          v-for="(workingtime, indexWorkingTime) in workingtimes" :key="indexWorkingTime"
          @click="setActiveWorkingtime(workingtime, indexWorkingTime)">
            {{ workingtime.start }}
          </li>
        </ul>
      </div>
      <div class="col-md-6">
        <div v-if="currentWorkingtime">
          <h4>Workingtime</h4>
          <div>
            <label><strong>start:</strong></label> {{ currentWorkingtime.start }}
          </div>
          <div>
            <label><strong>end:</strong></label> {{ currentWorkingtime.end }}
          </div>
          <div>
            <label><strong>user:</strong></label> {{ currentWorkingtime.users }}
          </div>
          <div>
            <label><strong>workingtime id:</strong></label> {{ currentWorkingtime.id }}
          </div>
          <a class="badge badge-warning" :href="'/#/workingtime/update/' + currentWorkingtime.users + '/' + currentWorkingtime.id ">
            Edit
          </a>
        </div>
        <div v-else>
          <br />
          <p>Please click on a workingtime...</p>
        </div>
      </div>
    </div>
    <div id="spaceur-10"></div>
  </div>
</template>

<script>
import WorkingtimeDataService from '../../services/WorkingTimeDataService'
import UserDataService from '../../services/UserDataService'

export default {
  name: 'workingtimes-list',
  data () {
    return {
      workingtimes: [],
      currentWorkingtime: null,
      currentIndexWorkingTime: -1,

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
    // Working Time
    // *******************************************
    retrieveWorkingtimes () {
      WorkingtimeDataService.getAll()
        .then(response => {
          this.workingtimes = response.data['data']
          console.log(response.data['data'])
        })
        .catch(e => {
          console.log(e)
        })
    },
    refreshListWorkingTime () {
      this.retrieveWorkingtimes()
      this.currentWorkingtime = null
      this.currentIndexWorkingTime = -1
    },
    setActiveWorkingtime (workingtime, indexWorkingTime) {
      this.currentWorkingtime = workingtime
      this.currentIndexWorkingTime = indexWorkingTime
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
    this.retrieveWorkingtimes()
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
