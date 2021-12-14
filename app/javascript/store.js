import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';
import router from './router';
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    password_digest: null,
    userId: null,
    searchWord: null,
  },
  getters: {
    password_digest: state => state.password_digest,
    userId: state => state.id,
    searchWord: state => state.location,
  },
  mutations: {
    updateToken(state, password_digest) {
      state.password_digest = password_digest;
    },
    updateUserId(state, userId) {
      state.userId = userId;
    },
    updateSearchWord(state, searchword) {
      state.searchWord = searchword;
    },
  },
  actions: {
    login({ commit }, authData) {
      axios
        .post("/api/v1/login", {
          user: {
            email: authData.email,
            password: authData.password,
          },
        })
        .then((response) => {
          console.log(response);
          commit('updateToken', response.data.password_digest);
          commit('updateUserId', response.data.id);
          router.push('/');
        })
        .catch((error) => {
          console.log(error);
          alert("入力内容に誤りがあります");
        })
    },
    logout({ commit }) {
      commit('updateToken', null);
      commit('updateUserId', null);
      router.push('/login');
    },
    search({ commit }, searchWord) {
      console.log(searchWord);
      commit('updateSearchWord', searchWord.searchWord);
      this.location = '';
      router.push(`/courts/search/${searchWord.searchWord}`)
    }
  },
  modules: {

  },
  plugins: [createPersistedState()]
});