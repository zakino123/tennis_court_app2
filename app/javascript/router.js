import Vue from 'vue';
import Router from 'vue-router';
import store from './store.js';
import CourtIndex from './src/pages/courts/index.vue'
import CourtNew from './src/components/courts/new.vue'
import UserShow from './src/pages/users/show.vue'
// import UserIndex from './src/components/Users/index.vue'
import CourtSearch from './src/pages/courts/search.vue'
import Login from './src/pages/login.vue'
import UserNew from './src/pages/user_new.vue'
import ContactNew from './src/pages/contact_new.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {path: '/', component: CourtIndex}, 
    {path: '/login', component: Login, beforeEnter(to, from, next) {
      if (store.getters.password_digest) {
        console.log('yes');
        next('/');
      } else {
        console.log('no');
        next();
      }
    }},
    // {path: '/users/new', component: UserNew},
    {path: '/user_create', component: UserNew, beforeEnter(to, from, next) {
      if (store.getters.password_digest) {
        next('/');
      } else {
        next();
      }
    }},
    {
      path: '/court_create', component: CourtNew, beforeEnter(to, from, next) {
        if (store.getters.password_digest) {
          next();
        } else {
          next('/login');
        }
      }
    },
    {path: '/contacts/new', component: ContactNew},
    {path: '/courts/search/:params', component: CourtSearch},
    {path: '/users/:id', component: UserShow, name: 'UserShow'},
    // {path: '/users', component: UserIndex},
  ]
});