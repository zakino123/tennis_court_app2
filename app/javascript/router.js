import Vue from 'vue';
import Router from 'vue-router';
import store from './store.js';
import CourtIndex from './src/pages/courts/index.vue'
import CourtNew from './src/components/courts/new.vue'
import TagSearchResult from './src/pages/courts/TagSearchResult.vue'
import UserShow from './src/pages/users/show.vue'
import UserEdit from './src/pages/users/edit.vue'
import CourtShow from './src/pages/courts/show.vue'
import CourtEdit from './src/components/courts/edit.vue'
import FollowerIndex from './src/components/users/UserFollowerIndex.vue'
import FollowingIndex from './src/components/users/UserFollowingIndex.vue'
import UserIndex from './src/pages/users/index.vue'
import CourtSearch from './src/pages/courts/search.vue'
import CourtSearchResult from './src/components/courts/CourtSearchResult.vue'
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
    {
      path: '/courts/edit/:id', component: CourtEdit, name: 'CourtEdit'
    },
    {path: '/users/edit/:id', component: UserEdit, name: 'UserEdit'},
    {path: '/courts/:id', component: CourtShow, name: 'CourtShow'},
    {path: '/contacts/new', component: ContactNew},
    {path: '/users/:id', component: UserShow, name: 'UserShow'},
    {path: '/users/:id/followers', component: FollowerIndex, name: 'FollowerIndex'},
    {path: '/users/:id/following', component: FollowingIndex, name: 'FollowingIndex'},
    {path: '/users', component: UserIndex},
    {path: '/tags/:id', component:  TagSearchResult, name: 'TagSearchResult'},
    {path: '/courts/search/:params', component: CourtSearchResult, name: 'CourtSearchResult'},
  ]
});