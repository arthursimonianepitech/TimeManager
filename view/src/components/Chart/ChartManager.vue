<template>
  <div>
    <div id="spaceur-10"></div>
    <h1>ChartManager</h1>
    <div id="spaceur-10"></div>
    <div>
      <DonutChart
        id="donut"
        :data="donutData"
        colors='[ "#FF6384", "#36A2EB", "#FFCE56" ]'
        resize="true">
      </DonutChart>
    </div>
    <div class="col-md-6">
        <h4>Workingtimes List</h4>
        <ul class="list-group">
          <li class="list-group-item" 
          :class="{ active: indexWorkingTime == currentIndexWorkingTime }"
          v-for="(workingtime, indexWorkingTime) in workingtimes " 
          :key="indexWorkingTime">
            <p v-if="workingtime.users == routeId">{{ workingtime.start }}</p>
          </li>
        </ul>
      </div>
  </div>
</template>

<script>
import { DonutChart } from 'vue-morris'
import WorkingtimeDataService from '../../services/WorkingTimeDataService'

export default {
  name: 'ChartManager',
  components: {
    DonutChart
  },
  data () {
    return {
      donutData: [
        { label: 'Red', value: 300 },
        { label: 'Blue', value: 50 },
        { label: 'Yellow', value: 100 }
      ],

      workingtimes: [],
      currentWorkingtime: null,
      currentIndexWorkingTime: -1,

      routeId: '',

      msg: 'Chart Manager'
    }
  },
  methods: {
    onInitFirst () {
      if (localStorage.getItem("connect") != "true") {
        window.location.href = "/#/login"
      }
    },
    getRouteId (){
      this.routeId = this.$route.params['id']
    },
    // *******************************************
    // Working Time
    // *******************************************
    retrieveWorkingtimes () {
      WorkingtimeDataService.getAll()
        .then(response => {
          this.workingtimes = response.data['data']
          console.log(response.data['data'])
        })
        .catch(e => {
          console.log(e)
        })
    },
    refreshListWorkingTime () {
      this.retrieveWorkingtimes()
      this.currentWorkingtime = null
      this.currentIndexWorkingTime = -1
    },
    setActiveWorkingtime (workingtime, indexWorkingTime) {
      this.currentWorkingtime = workingtime
      this.currentIndexWorkingTime = indexWorkingTime
    }
  },
  mounted () {
    this.onInitFirst()
    this.retrieveWorkingtimes()
    this.getRouteId()
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
