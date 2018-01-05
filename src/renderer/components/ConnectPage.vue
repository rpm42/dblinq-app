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
      <h3 class="align">Connect Database</h3>
      <v-layout row>
        <v-flex xs4><v-subheader>Host</v-subheader></v-flex>
        <v-flex xs8><v-text-field name="host" label="Host" v-model="access.host"></v-text-field></v-flex>
      </v-layout>

      <v-layout row>
        <v-flex xs4><v-subheader>Port</v-subheader></v-flex>
        <v-flex xs8><v-text-field name="port" label="Port" v-model="access.port"></v-text-field></v-flex>
      </v-layout>

      <v-layout row>
        <v-flex xs4><v-subheader>User</v-subheader></v-flex>
        <v-flex xs8><v-text-field name="user" label="User" v-model="access.user"></v-text-field></v-flex>
      </v-layout>

      <v-layout row>
        <v-flex xs4><v-subheader>Password</v-subheader></v-flex>
        <v-flex xs8><v-text-field name="password" label="Password" v-model="access.password"></v-text-field></v-flex>
      </v-layout>

      <v-layout row>
        <v-flex xs4><v-subheader>Database</v-subheader></v-flex>
        <v-flex xs8><v-text-field name="database" label="Database" v-model="access.database"></v-text-field></v-flex>
      </v-layout>
      <v-layout row>
        <v-flex xs12><v-btn @click="connectTest()">Connect</v-btn></v-flex>
      </v-layout>
    </div>
  </v-container>
</template>

<script>
import mysql from 'mysql'
// import Promise from Promise
export default {
  name: 'ConnectPage',
  data () {
    return {
      error: '',
      showResult: false,
      access: {
        host: '127.0.0.1',
        port: 3306,
        user: 'dbtest',
        password: 'dbtest',
        database: 'dbtest'
      }
    }
  },
  methods: {
    connectTest () {
      let connection = mysql.createConnection(this.access)
      connection.connect((error, result) => {
        if (error) {
          this.error = error
        } else {
          this.error = ''
          connection.end()
          console.log(result)
        }
        this.showResult = true
      })
    },
    doQuery (queryStr, access) {
      return new Promise((resolve, reject) => {
        try {
          let connection = mysql.createConnection(access)
          connection.query(queryStr, (error, results, fields) => {
            connection.destroy()
            console.log(results)
            if (error) {
              this.error = error
              reject(error)
            } else {
              console.log(results)
              this.showResult = true
            }
            return resolve(results)
          })
        } catch (error) {
          this.error = error
          this.showResult = true
        }
      })
    }
  }
}
</script>
