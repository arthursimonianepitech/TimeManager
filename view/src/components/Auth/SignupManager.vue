<template>
<div id="main">
  <nav class="navbar transparent navbar-inverse navbar-fixed-top">
    <p class="navbar-brand" >Time Manager</p>
  </nav>
  <div class="login">
    <h1>Créer un compte</h1>
    <div id="spaceur-5"></div>
    <p>Vous déjà un compte ? <a href="#/login">Connectez-vous !</a></p>
    <div id="spaceur-5"></div>
    <div v-if="!submitted">
        <input
          type="text" class="input" id="email"  required  v-model="user.email" name="email" placeholder="Email"
        />
        <input
          type="text" class="input" id="username"  required  v-model="user.username" name="username" placeholder="Username"
        />
        <input
          type="password" class="input" id="password"  required  v-model="user.password" name="password" placeholder="Mot de passe"
        />
        <input
          type="password_confirmation" class="input" id="password_confirmation"  required  v-model="user.password_confirmation" name="password_confirmation" placeholder="Mot de passe vérification"
        />
        <button @click="saveUser" class="btn btn-primary btn-block btn-large input">Entrer</button>
    </div>
    <div v-else>
      <h4>You submitted successfully!</h4>
    </div>
  </div>
</div>
</template>

<script>
import AuthDataService from '../../services/AuthDataService'

export default {
  name: 'sign_up',
  data () {
    return {
      user: {
        id: null,
        email: '',
        username: '',
        password: '',
        password_confirmation: ''
      },
      submitted: false
    }
  },
  methods: {
    saveUser () {
      var data = {
        user: {
          email: this.user.email,
          username: this.user.username,
          password: this.user.password,
          password_confirmation: this.user.password_confirmation
        }
      }
      AuthDataService.register(data)
        .then(response => {
          console.log(response.data)
          localStorage.setItem('connect',true);
          localStorage.setItem('token',response.data.jwt);
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

<style scoped>
@import url(https://fonts.googleapis.com/css?family=Open+Sans);

#spaceur-5 {
    height: 5vh;
  }
  
  .navbar-brand {
    color: white;
    margin-left: 3vw;
    margin-top: 2%;
  }
  .nav-item {
    color: black;
    margin-left: 3vw;
  }
  
  html { 
    width: 100vw; 
    height:100vh; 
    overflow:hidden; 
  }
  
  #main { 
      width: 100vw;
      height:100vh;
      font-family: 'Open Sans', sans-serif;
      background: #092756;
      background: -moz-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%),-moz-linear-gradient(top,  rgba(57,173,219,.25) 0%, rgba(42,60,87,.4) 100%), -moz-linear-gradient(-45deg,  #670d10 0%, #092756 100%);
      background: -webkit-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), -webkit-linear-gradient(top,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), -webkit-linear-gradient(-45deg,  #670d10 0%,#092756 100%);
      background: -o-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), -o-linear-gradient(top,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), -o-linear-gradient(-45deg,  #670d10 0%,#092756 100%);
      background: -ms-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), -ms-linear-gradient(top,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), -ms-linear-gradient(-45deg,  #670d10 0%,#092756 100%);
      background: -webkit-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), linear-gradient(to bottom,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), linear-gradient(135deg,  #670d10 0%,#092756 100%);
      filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3E1D6D', endColorstr='#092756',GradientType=1 );
  }
  .login { 
      width:40vw;
      margin-top: 6vh;
      margin-left: 30vw;
  }
  .login h1 { 
    color: #fff; 
    text-shadow: 0 0 10px rgba(0,0,0,0.3); 
    letter-spacing:1px; 
  }
  .login p {
    color: #fff;
  }
  input { 
      width: 100%; 
      background: rgba(0,0,0,0.3);
      border: none;
      outline: none;
      padding: 15px;
      color: #fff;
      text-shadow: 1px 1px 1px rgba(0,0,0,0.3);
      border: 1px solid rgba(0,0,0,0.3);
      border-radius: 4px;
      box-shadow: inset 0 -5px 45px rgba(100,100,100,0.2), 0 1px 1px rgba(255,255,255,0.2);
      -webkit-transition: box-shadow .5s ease;
      -moz-transition: box-shadow .5s ease;
      -o-transition: box-shadow .5s ease;
      -ms-transition: box-shadow .5s ease;
      transition: box-shadow .5s ease;
  }
  input:focus { box-shadow: inset 0 -5px 45px rgba(100,100,100,0.4), 0 1px 1px rgba(255,255,255,0.2); }
  .input{
    margin-bottom: 20px;
  }
</style>

