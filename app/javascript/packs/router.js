import Vue from 'vue';
import Router from 'vue-router';
import CourtIndex from './src/pages/courts/court_index.vue'
import Login from './src/pages/login.vue'
import UserNew from './src/pages/user_new.vue'
import ContactNew from './src/pages/contact_new.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {path: '/', component: CourtIndex}, 
    {path: '/login', component: Login},
    {path: '/users/new', component: UserNew},
    {path: '/contacts/new', component: ContactNew},
  ]
});