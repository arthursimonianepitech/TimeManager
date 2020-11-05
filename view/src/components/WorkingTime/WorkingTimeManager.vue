<template>
  <div v-if="currentWorkingtime" class="edit-form">
    <div id="spaceur-10"></div>
    <h1>Edit workingtime</h1>
    <h3>
      {{user.username}} <br>
      {{user.email}}
    </h3>
    <div id="spaceur-10"></div>
    <form>
      <div class="form-group">
        <label for="start">start</label>
        <input type="datetime-local" class="form-control" id="start" v-model="currentWorkingtime.start" />
      </div>
      <div class="form-group">
        <label for="end">end</label>
        <input type="datetime-local" class="form-control" id="end" v-model="currentWorkingtime.end" />
      </div>
    </form>
    <button class="badge badge-danger mr-2" @click="deleteWorkingtime">
      Delete
    </button>
    <button type="submit" class="badge badge-success" @click="updateWorkingtime">
      Update
    </button>
    <p>{{ message }}</p>
  </div>

  <div v-else>
    <br />
    <p>Please click on a Workingtime...</p>
  </div>
</template>

<script>
import WorkingtimeDataService from '../../services/WorkingTimeDataService'
import UserDataService from '../../services/UserDataService'

export default {
  name: 'workingtime',
  data () {
    return {
      user: [],
      currentWorkingtime: [],
      message: ''
    }
  },
  methods: {
    onInitFirst () {
      if (localStorage.getItem("connect") != "true") {
        window.location.href = "/#/login"
      }
    },
    getWorkingtime (userid, id) {
      WorkingtimeDataService.get(userid, id)
        .then(response => {
          this.currentWorkingtime = response.data['data']
          console.log(response.data['data'])
        })
        .catch(e => {
          console.log(e)
        })
    },

    updateWorkingtime () {
      var data = {
        working_times: {
          start: this.currentWorkingtime.start,
          end: this.currentWorkingtime.end
        }
      }
      WorkingtimeDataService.update(this.$route.params['id'], data)
        .then(response => {
          console.log(response.data['data'])
          this.message = 'The workingtime was updated successfully!'
        })
        .catch(e => {
          console.log(e)
        })
    },

    deleteWorkingtime () {
      WorkingtimeDataService.delete(this.$route.params['id'])
        .then(response => {
          console.log(response.data['data'])
          this.$router.push({ name: 'workingtimes' })
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
    this.getWorkingtime(this.$route.params['userid'], this.$route.params['id'])
    this.getUser(this.$route.params['userid'])
  }
}
</script>

<style>
.edit-form {
  max-width: 300px;
  margin: auto;
}
#spaceur-10 {
  height: 10vh;
}
</style>
