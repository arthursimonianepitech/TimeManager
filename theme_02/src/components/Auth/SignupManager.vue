<template>
<div>
  <div id="spaceur-10"></div>
    <h1>AddUser</h1>
  <div id="spaceur-10"></div>
  <div class="submit-form">
    <div v-if="!submitted">
      <div class="form-group">
        <label for="email">email</label>
        <input
          type="text"
          class="form-control"
          id="email"
          required
          v-model="user.email"
          name="email"
        />
      </div>

      <div class="form-group">
        <label for="username">username</label>
        <input
          class="form-control"
          id="username"
          required
          v-model="user.username"
          name="username"
        />
      </div>

      <button @click="saveUser" class="btn btn-success">Submit</button>
    </div>

    <div v-else>
      <h4>You submitted successfully!</h4>
      <button class="btn btn-success" @click="newUser">Add</button>
    </div>
  </div>
</div>
</template>

<script>
import UserDataService from '../../services/UserDataService'

export default {
  name: 'users-add',
  data () {
    return {
      user: {
        id: null,
        email: '',
        username: ''
      },
      submitted: false
    }
  },
  methods: {
    saveUser () {
      var data = {
        user: {
          email: this.user.email,
          username: this.user.username
        }
      }
      UserDataService.create(data)
        .then(response => {
          this.user.id = response.data.id
          console.log(response.data)
          this.submitted = true
        })
        .catch(e => {
          console.log(e)
        })
    },
    newUser () {
      this.submitted = false
      this.user = {}
    }
  }
}
</script>

<style>
.submit-form {
  max-width: 300px;
  margin: auto;
}
#spaceur-10 {
  height: 10vh;
}
</style>
