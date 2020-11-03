<template>
  <div id="app">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="/">TimeMankager</a>
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
                <a class="nav-link" href="/#/workingTime">workingTime</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/#/clock">ClockManager</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/#/chartManager">chartManager</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/#/users">userManager</a>
              </li>
            </ul>
          </div>
          <div>
            <ul class="navbar-nav">
              <li class="nav-item">
                <a class="nav-link" href="/#/">Déconnexion</a>
              </li>
            </ul>
          </div>
      </div>
    </nav>
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App'
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
.navtext{
  display:flex;
  justify-content: space-between;
}
</style>
