<template>
  <div>
    <div class="mainpictures">
      <h1>Time manager</h1>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
    </div>
    <div class="mainSubpicture">  
      <div class="subpicture subpicture1">
        <h1>Time manager</h1>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
      </div>
      <div class="subpicture subpicture2">
        <h1>Time manager</h1>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
      </div>
    </div>
    <div id="spaceur-10"></div>
    <div id="spaceur-10"></div>
  </div>
</template>

<script>
export default {
  name: 'Home',
  data () {
    return {
      msg: 'Home page',
      jwt: ''
    }
  },
  methods: {
    onInitFirst () {
      if (localStorage.getItem("connect") != "true") {
        window.location.href = "/#/login"
      }
    },
    getToken () {
      this.jwt = localStorage.getItem('token')
    }
  },
  mounted (){
    this.onInitFirst()
    this.getToken()
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#spaceur-10 {
  height: 10vh;
}

.mainpictures {
  margin-left: auto;
  margin-right: auto;
  width: 70%;
  height: 70vh;

  margin-top: 20vh;

  background: url("https://cdn.pixabay.com/photo/2019/02/03/18/23/lighthouse-3973197_1280.jpg");
  background-size: cover;
  background-position: bottom;
}
.mainSubpicture {
  display: flex;
  justify-content: space-between;

  margin-left: auto;
  margin-right: auto;
  width: 70%;
  height: 70vh;
}
.subpicture {
  width: 48%;
  height: 70vh;
  margin-top: 5vh;

  background-color: grey;
}
</style>
