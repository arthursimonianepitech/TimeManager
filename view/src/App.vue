<template>
  <div id="app">
    <div id="fullnavbar">
      <div id="navbartop">
        <nav class="navbar navbar-expand-lg topnav"  v-if="connect == 'true'">
          <a class="navbar-brand" href="/" style="color:white">TimeManager</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse navtext" id="navbarNav">
              <div></div>
              <div>
                <ul class="navbar-nav">
                  <li class="nav-item">
                    <a class="nav-link" href="/#/logout">Déconnexion</a>
                  </li>
                </ul>
              </div>
          </div>
        </nav>
      </div>
      <div id="navbartop">
        <nav class="navbar navbar-expand-lg subnav"  v-if="connect == 'true'">
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse navtext" id="navbarNav">
              <div>
                <ul class="navbar-nav">
                  <!--
                  <li class="nav-item ">
                    <a class="nav-link" href="/#/workingTimes">workingTimes</a>
                  </li>
                  -->
                  <li class="nav-item">
                    <a class="nav-link" href="/#/workingTime">WorkingTime</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="/#/clock">ClockManager</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="/#/chartManager">ChartManager</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="/#/users">UserManager</a>
                  </li>
                </ul>
              </div>
          </div>
        </nav>
      </div>
    </div>
    <router-view/>
    <footer>
      <div id="navbartop">
        <nav class="navbar navbar-expand-lg footernav"  v-if="connect == 'true'">
          <div class="collapse navbar-collapse navtext" id="navbarNav">
            <div>
              <ul class="navbar-nav">
                <li class="nav-item">
                  <a class="nav-link" href="/#/workingTime">WorkingTime</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/#/clock">ClockManager</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/#/chartManager">ChartManager</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/#/users">UserManager</a>
                </li>
              </ul>
            </div>
          </div>
        </nav>
      </div>
      <div class="middlefooter">
        <p>TIMEMANAGER 2020 © ALL RIGHTS RESERVED</p>
      </div>
      <div class="subfooter">
        <p>TIMEMANAGER 2020 © ALL RIGHTS RESERVED</p>
      </div>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'APP',
  data () {
    return {
      msg: 'APP',
      connect: ''
    }
  },
  methods: {
    getLocalStorage () {
      this.connect = localStorage.getItem('connect')
    }
  },
  mounted (){
    this.getLocalStorage()
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
#spaceur-10 {
  height: 10vh;
}
#fullnavbar{
  position: fixed; /* Set the navbar to fixed position */
  top: 0; /* Position the navbar at the top of the page */
  width: 100%; /* Full width */
}
.navtext{
  display:flex;
  justify-content: space-between;
}
.topnav{
  background-color: black;
  color: white;
}
.topnav a{
  color: grey;
}
.topnav a:hover{
  color: white;
}
.navbar-brand{
  color: white;
}
.subnav{
  height: 5vh;
  background-color: rgba(0, 0, 0, 0);
}
.subnav a {
  padding-top: 25px;
  color: black; 
  text-shadow: 0 0 10px rgba(0,0,0,0.3); 
  letter-spacing:1px; 
}
.subnav a:hover {
  color: #636363;
}

.footernav{
  height: 15vh;
  background-color: black;
}
.footernav ul{
  padding-left: 1.5vw;
}
.footernav a{
  color: white;
  font-size: 1.1em;
}
.footernav a:hover{
  color: #636363;
}
.subfooter{
  margin: 0%;
  background-color: black;
  height: 5vh;

  color: white;
  font-size: 0.9em;

  text-align: left;
  padding-left: 3vw;

  margin-bottom: -2vw;
}
.subfooter p{
  line-height: 5vh;
}
</style>
