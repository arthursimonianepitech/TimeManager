import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import WorkingTimes from '../components/WorkingTimes'
import ChartManager from '../components/ChartManager'

import WorkingTimeManager from '../components/WorkingTime/WorkingTimeManager'
import WorkingTimeManagerList from '../components/WorkingTime/WorkingTimeManagerList'
import AddWorkingTimeManager from '../components/WorkingTime/AddWorkingTimeManager'
import WorkingTimeManagerByUser from '../components/WorkingTime/WorkingTimeManagerByUser'

import ClockManager from '../components/Clock/ClockManager'
import ClockManagerList from '../components/Clock/ClockManagerList'
import AddClockManager from '../components/Clock/AddClockManager'

import UserManager from '../components/User/UserManager'
import UserManagerList from '../components/User/UserManagerList'
import AddUserManager from '../components/User/AddUserManager'

import SignupManager from '../components/Auth/SignupManager.vue'
import LoginManager from '../components/Auth/LoginManager.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/workingTimes',
      name: 'WorkingTimes',
      component: WorkingTimes
    },
    {
      path: '/chartManager',
      name: 'ChartManager',
      component: ChartManager
    },
    // ******************************************** //
    // *********** WORKINGTIME MANAGEMENT ********* //
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv //
    {
      path: '/workingtime',
      name: 'workingtime',
      component: WorkingTimeManagerList
    },
    {
      path: '/workingtime/update/:userid/:id', // working time by workingtime id
      name: 'workingtime-detail',
      component: WorkingTimeManager
    },
    {
      path: '/workingtime/add/:id',
      name: 'workingtime-add',
      component: AddWorkingTimeManager
    },
    {
      path: '/workingtime/user/:id', // working time by user id
      name: 'workingtime-detail',
      component: WorkingTimeManagerByUser
    },
    // ******************************************** //
    // ************** CLOCK MANAGEMENT ************ //
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv //
    {
      path: '/clock',
      name: 'clock',
      component: ClockManagerList
    },
    {
      path: '/clock/:id',
      name: 'clock-detail',
      component: ClockManager
    },
    {
      path: '/clock/add/:id',
      name: 'clock-add',
      component: AddClockManager
    },
    // ******************************************** //
    // ************** USER MANAGEMENT ************* //
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv //
    {
      path: '/users',
      name: 'users',
      component: UserManagerList
    },
    {
      path: '/users/:id',
      name: 'users-detail',
      component: UserManager
    },
    {
      path: '/user/add',
      name: 'user-add',
      component: AddUserManager
    },
    // ******************************************** //
    // ************** AUTHENTICATION ************** //
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv //
    {
      path: '/signup',
      name: 'signup',
      component: SignupManager
    },
    {
      path: '/login',
      name: 'login',
      component: LoginManager
    }
  ]
})
