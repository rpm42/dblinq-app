<template>
  <v-container fluid>
    <div v-if="showResult">
      <v-layout>
        <div v-if="error">
          <h1 class="red--text my-2">Error</h1>
          <pre>{{error}}</pre>
          <v-btn class="ma-0" @click="showResult=false">Back</v-btn>
        </div>
        <div v-else>
          <h1 class="green--text my-2">OK!</h1>
          <v-btn class="ma-0" @click="showResult=false">Back</v-btn>
        </div>
      </v-layout>
    </div>
    <div v-else>
      <h3 class="align">Connect Tables</h3>
      <v-layout row>
        <v-flex xs12><v-btn class="ma-0" @click="createTables()">Create</v-btn></v-flex>
      </v-layout>
    </div>
  </v-container>
</template>

<script>
import mysql from 'mysql'
import { mapState } from 'vuex'
import tables from '@/data/tables'
import data from '@/data/data'

// import Promise from Promise
export default {
  name: 'ConnectPage',
  data () {
    return {
      error: '',
      showResult: false
    }
  },
  computed: mapState(['access']),
  methods: {
    async createTables () {
      console.log(tables)
      console.log(data)

      console.log(await this.doQuery('SHOW TABLES'))
      try {
        console.log(await this.doQuery(tables.products))
        console.log(await this.doQuery(tables.cart))
        console.log(await this.doQuery(data.products))
        console.log(await this.doQuery(data.cart))
        this.error = ''
      } catch (error) {
        this.error += `\n\n${error}`
      }
      this.showResult = true
    },
    doQuery (queryStr) {
      return new Promise((resolve, reject) => {
        try {
          let connection = mysql.createConnection(this.access)
          connection.query(queryStr, (error, results, fields) => {
            connection.destroy()
            console.log(results)
            if (error) {
              this.error = error
              reject(error)
            }
            return resolve(results)
          })
        } catch (error) {
          this.error += `\n\n${error}`
          // this.showResult = true
        }
      })
    }
  }
}
</script>
