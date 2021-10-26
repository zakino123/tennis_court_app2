import Vue from 'vue';
import Router from 'vue-router';
// import store from './store.js';
import CourtIndex from './src/pages/courts/index.vue'
// import CourtNew from './src/pages/courts/new.vue'
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
    {path: '/login', component: Login},
    // {path: '/login', component: Login, beforeEnter(to, from, next) {
    //   if (store.getters.token) {
    //     console.log('yes');
    //     next('/');
    //   } else {
    //     console.log('no');
    //     next();
    //   }
    // }},
    {path: '/users/new', component: UserNew},
    // {path: '/users/new', component: UserNew, beforeEnter(to, from, next) {
    //   if (store.getters.token) {
    //     next('/');
    //   } else {
    //     next();
    //   }
    // }},
    // {
    //   path: '/courts/new', component: CourtNew, beforeEnter(to, from, next) {
    //     if (store.getters.token) {
    //       next();
    //     } else {
    //       next('/login');
    //     }
    //   }
    // },
    {path: '/contacts/new', component: ContactNew},
    {path: '/courts/search/:params', component: CourtSearch},
    {path: '/users/:id', component: UserShow},
    // {path: '/users', component: UserIndex},
  ]
});