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
      <h3 class="align">Add Product</h3>

      <v-layout row>
        <v-flex xs4><v-subheader>Product name</v-subheader></v-flex>
        <v-flex xs8><v-text-field name="name" label="Product name" v-model="product.name"></v-text-field></v-flex>
      </v-layout>

      <v-layout row>
        <v-flex xs4><v-subheader>Price</v-subheader></v-flex>
        <v-flex xs8><v-text-field name="price" label="Price" v-model="product.price"></v-text-field></v-flex>
      </v-layout>
      <v-layout row>
        <v-flex xs12><v-btn @click="addProduct()">Add</v-btn></v-flex>
      </v-layout>
    </div>
    <v-snackbar multi-line :timeout="3000" top v-model="snackbar">
      <p v-if="error" class="red--text my-2">{{ error }}</p>
      <p v-else class="green--text my-2">Product added!</p>
      <v-btn flat color="pink" @click.native="snackbar = false">Close</v-btn>
    </v-snackbar>
  </v-container>
</template>

<script>
import mysql from 'mysql'
import { mapState } from 'vuex'

export default {
  name: 'AddProduct',
  data () {
    return {
      error: '',
      showResult: false,
      snackbar: false,
      product: {
        name: 'Хлеб Новый, 1шт',
        price: 1.00
      }
    }
  },
  computed: mapState(['access']),
  methods: {
    async addProduct () {
      const sql = mysql.format('INSERT INTO ?? SET ?', ['products', this.product])
      console.log(sql)
      try {
        const status = await this.doQuery(sql)
        console.log(status)
        this.error = ''
        this.snackbar = true
      } catch (e) {
        console.log(e)
        this.error = e.message
        this.snackbar = true
      }
    },
    doQuery (queryStr) {
      return new Promise((resolve, reject) => {
        try {
          let connection = mysql.createConnection(this.access)
          connection.query(queryStr, (error, results, fields) => {
            connection.destroy()
            if (error) {
              this.error = error
              reject(error)
            }
            return resolve(results)
          })
        } catch (error) {
          // this.error += `\n\n${error}`
          reject(error)
          // this.showResult = true
        }
      })
    }
  }
}
</script>
