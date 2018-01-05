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

      <div v-if="loading">
        <p>loading...</p>
      </div>
      <v-data-table
        v-else
        v-model="selected"
        :headers="headers"
        :items="products"
        hide-actions
      >
        <template slot="items" slot-scope="props">
          <tr :active="props.selected" @click="props.selected = !props.selected">
            <td>
              <v-checkbox
                primary
                hide-details
                :input-value="props.selected"
              ></v-checkbox>
            </td>
            <td>{{ props.item.id }}</td>
            <td>{{ props.item.name }}</td>
            <td>{{ props.item.price }}</td>
            <td>
              <v-edit-dialog
                @open="tmp = props.item.count"
                @save="props.item.count = tmp || props.item.count"
                large
                lazy
              >
                <div>{{ props.item.count }}</div>
                <div slot="input" class="mt-3 title">Update Count</div>
                <v-text-field
                    slot="input"
                    label="Edit"
                    v-model="tmp"
                    single-line
                    counter
                    autofocus
                ></v-text-field>
              </v-edit-dialog>
            </td>
          </tr>
        </template>
      </v-data-table>
      
      <v-layout row>
        <v-flex xs12><v-btn @click="addProduct()">Add to Cart</v-btn></v-flex>
      </v-layout>
    </div>
    <v-snackbar multi-line :timeout="3000" top v-model="snackbar">
      <p v-if="error" class="red--text my-2">{{ error }}</p>
      <p v-else class="green--text my-2">Product added to cart!</p>
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
      tmp: 1,
      showResult: false,
      snackbar: false,
      products: [],
      selected: [],
      loading: true,
      headers: [
        { text: '', value: 'selected', align: 'left', sortable: false },
        { text: 'ID', value: 'id', align: 'left', sortable: true },
        { text: 'Name', value: 'name', align: 'left', sortable: true },
        { text: 'Price', value: 'price', align: 'left', sortable: true },
        { text: 'Count', value: 'count', align: 'left', sortable: true }
      ]
    }
  },
  mounted () {
    this.doQuery('SELECT * FROM `products`').then(products => {
      this.loading = false
      console.log(products)
      this.products = products.map(item => {
        return {
          ...item,
          count: 1
        }
      })
    }).catch(error => {
      console.error(error)
      this.error = error
    })
  },
  computed: mapState(['access']),
  methods: {
    async addProduct () {
      console.log(this.selected)
      let result = this.selected.map(item => {
        return [ item.id, +item.count, null ]
      })
      const sql = mysql.format('INSERT INTO ?? (??) VALUES ?', ['cart', ['product_id', 'count', 'weight'], result])
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
