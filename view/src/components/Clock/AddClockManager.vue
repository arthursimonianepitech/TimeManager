<template>
<div>
    <div id="spaceur-10"></div>
    <h1>Add clockManager</h1>
    <h3>
      {{user.username}} <br>
      {{user.email}}
    </h3>
    <div id="spaceur-10"></div>
    <div class="submit-form">
        <div v-if="!submitted">
        <div class="form-group">
            <label for="time">time</label>
            <input
            type="datetime-local"
            class="form-control"
            id="time"
            required
            v-model="clocks.time"
            name="time"
            />
        </div>

        <div class="form-group">
            <label for="status">status</label>
            <input
            type="checkbox"
            class="form-control"
            id="status"
            required
            v-model="clocks.status"
            name="status"
            />
        </div>

        <button @click="saveClock" class="btn btn-success">Submit</button>
        </div>

        <div v-else>
        <h4>You submitted successfully!</h4>
        <button class="btn btn-success" @click="newClock">Add</button>
        </div>
    </div>
</div>
</template>

<script>
import ClockDataService from '../../services/ClockDataService'
import UserDataService from '../../services/UserDataService'

export default {
  name: 'add-clock',
  data () {
    return {
      user: [],
      clocks: {
        id: null,
        time: '',
        status: ''
      },
      submitted: false
    }
  },
  methods: {
    onInitFirst () {
      if (localStorage.getItem("connect") != "true") {
        window.location.href = "/#/login"
      }
    },
    saveClock () {
      var data = {
        clocks: {
          time: this.clocks.time,
          status: this.clocks.status
        }
      }
      ClockDataService.create(this.$route.params['id'], data)
        .then(response => {
          this.clocks.id = response.data.id
          console.log(response.data)
          this.submitted = true
        })
        .catch(e => {
          console.log(e)
        })
    },
    newClock () {
      this.submitted = false
      this.clocks = {}
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
    this.getUser(this.$route.params['id'])
  }
}
</script>

<style>
.submit-form {
  max-width: 300px;
  margin: auto;
}
</style>
