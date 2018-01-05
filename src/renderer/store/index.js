import Vue from 'vue'
import Vuex from 'vuex'

// import modules from './modules'

Vue.use(Vuex)

const state = {
  access: {
    host: '127.0.0.1',
    port: 3306,
    user: 'dbtest',
    password: 'dbtest',
    database: 'dbtest'
  }
}

const mutations = {
  SET_ACCESS (state, access) {
    Vue.set(state, 'access', access)
  }
}

export default new Vuex.Store({
  state,
  mutations,
  strict: process.env.NODE_ENV !== 'production'
})
