<template>
  <div>
    <div id="spaceur-10"></div>
    <h1>ChartManager</h1>
    <div id="spaceur-10"></div>
    <div>
      <donut-chart
        id="donut"
        :data="donutData"
        colors='[ "#FF6384", "#36A2EB", "#FFCE56" ]'
        resize="true">
      </donut-chart>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ChartManager',
  data () {
    return {
      msg: 'Chart Manager'
    }
  }
}
</script>

<!-- Add 'scoped' attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
