import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'landing-page',
      component: require('@/components/DatabasePage').default
    },
    {
      path: '/connect',
      name: 'connect-page',
      component: require('@/components/ConnectPage').default
    },
    {
      path: '/create-tables',
      name: 'create-tables-page',
      component: require('@/components/CreateTables').default
    },
    {
      path: '/add-product',
      name: 'add-product-page',
      component: require('@/components/AddProducts').default
    },
    {
      path: '/cart',
      name: 'add-to-cart-page',
      component: require('@/components/AddToCart').default
    }
  ]
})
