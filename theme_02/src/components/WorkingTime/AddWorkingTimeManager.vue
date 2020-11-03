<template>
<div>
    <div id="spaceur-10"></div>
    <h1>Add workingtimeManager</h1>
    <h3>
      {{user.username}} <br>
      {{user.email}}
    </h3>
    <div id="spaceur-10"></div>
    <div class="submit-form">
        <div v-if="!submitted">
        <div class="form-group">
            <label for="start">start</label>
            <input
            type="datetime-local"
            class="form-control"
            id="start"
            required
            v-model="workingTime.start"
            name="start"
            />
        </div>

        <div class="form-group">
            <label for="end">end</label>
            <input
            type="datetime-local"
            class="form-control"
            id="end"
            required
            v-model="workingTime.end"
            name="end"
            />
        </div>

        <button @click="saveWorkingTime" class="btn btn-success">Submit</button>
        </div>

        <div v-else>
        <h4>You submitted successfully!</h4>
        <button class="btn btn-success" @click="newworkingTime">Add</button>
        </div>
    </div>
</div>
</template>

<script>
import workingTimeDataService from '../../services/WorkingTimeDataService'
import UserDataService from '../../services/UserDataService'

export default {
  name: 'add-WorkingTime',
  data () {
    return {
      user: [],
      workingTime: {
        id: null,
        start: '',
        end: '',
        published: false
      },
      submitted: false
    }
  },
  methods: {
    saveWorkingTime () {
      var data = {
        working_times: {
          start: this.workingTime.start,
          end: this.workingTime.end
        }
      }
      workingTimeDataService.create(this.$route.params['id'], data)
        .then(response => {
          this.workingTime.id = response.data.id
          console.log(response.data)
          this.submitted = true
        })
        .catch(e => {
          console.log(e)
        })
    },
    newWorkingTime () {
      this.submitted = false
      this.workingTime = {}
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
