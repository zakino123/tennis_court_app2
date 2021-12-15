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
    // searchSelection: null,
  },
  getters: {
    password_digest: state => state.password_digest,
    userId: state => state.id,
    searchWord: state => state.location,
    // searchSelection: state => state.keyword,
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
    // updateSearchSelection(state, searchselection) {
    //   state.searchSelection = searchselection;
    // },
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
    // search({ commit }, {searchWord, searchSelection}) {
      console.log(searchWord);
      // console.log(searchSelection);
      commit('updateSearchWord', searchWord.searchWord);
      // commit('updateSearchSelection', searchSelection.searchSelection);
      this.location = '';
      // this.keyword = '';
      // router.push(`/courts/search/${searchWord.searchWord}/${searchSelection.searchSelection}`)
      router.push(`/courts/search/${searchWord.searchWord}`)
    }
  },
  modules: {

  },
  plugins: [createPersistedState()]
});