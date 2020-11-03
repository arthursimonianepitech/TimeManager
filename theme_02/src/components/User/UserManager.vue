<template>
  <div v-if="currentUser" class="edit-form">
    <div id="spaceur-10"></div>
    <h1>Edit User</h1>
    <div id="spaceur-10"></div>
    <form>
      <div class="form-group">
        <label for="email">email</label>
        <input type="text" class="form-control" id="email" v-model="currentUser.email" />
      </div>
      <div class="form-group">
        <label for="username">username</label>
        <input type="text" class="form-control" id="username" v-model="currentUser.username" />
      </div>
    </form>
    <button class="badge badge-danger mr-2" @click="deleteUser">
      Delete
    </button>
    <button type="submit" class="badge badge-success" @click="updateUser">
      Update
    </button>
    <p>{{ message }}</p>
  </div>

  <div v-else>
    <br />
    <p>Please click on a user...</p>
  </div>
</template>

<script>
import UserDataService from '../../services/UserDataService'

export default {
  name: 'user',
  data () {
    return {
      currentUser: [],
      message: ''
    }
  },
  methods: {
    getUser (id) {
      UserDataService.get(id)
        .then(response => {
          this.currentUser = response.data['data']
          console.log(response.data['data'])
        })
        .catch(e => {
          console.log(e)
        })
    },
    updateUser () {
      var data = {
        user: {
          username: this.currentUser.username,
          email: this.currentUser.email
        }
      }
      UserDataService.update(this.$route.params['id'], data)
        .then(response => {
          console.log(response.data['data'])
          this.message = 'The user was updated successfully!'
        })
        .catch(e => {
          console.log(e)
        })
    },
    deleteUser () {
      UserDataService.delete(this.$route.params['id'])
        .then(response => {
          console.log(response.data['data'])
          this.$router.push({ name: 'users' })
        })
        .catch(e => {
          console.log(e)
        })
    }
  },
  mounted () {
    this.message = ''
    this.getUser(this.$route.params['id'])
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
