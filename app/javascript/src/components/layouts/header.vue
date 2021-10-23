<template>
  <header class="bg-green-100">
    <div class="container mx-auto flex flex-wrap flex-col md:flex-row items-center py-1">
      <div class="header-left flex-row md:flex">
        <div class="text-center mb-3 md:mb-0">
          <router-link to="/" class="h5 my-0 fw-normal fs-1 ps-5 text-info title-font">Tennis court search</router-link>
          <nav class="ml-3 mt-4 float-end text-base md:text-2xl">
            <router-link to="/" class="ml-2 m-2 hover:text-blue-400">ホーム</router-link>
            <template v-if="isAuthenticated">
              <router-link :to="{ name: 'UserShow', params: { id: this.$store.state.userId } }" class="m-1 hover:text-blue-400">マイページ</router-link>
              <router-link to="/courts/new" class="m-1 hover:text-blue-400">コート投稿</router-link>
              <router-link to="/users" class="m-1 hover:text-blue-400">ユーザー一覧</router-link>
              <button @click="logout()" class="m-1 hover:text-blue-400">ログアウト</button>
            </template>
            <template v-if="!isAuthenticated">
              <router-link to="/login" class="m-1 hover:text-blue-400">ログイン</router-link>
              <router-link to="/users/new" class="m-1 hover:text-blue-400">新規登録</router-link>
            </template>
          </nav>
        </div>
      </div>
    </div>
  </header>
</template>

<script>
// export default {
//   data: function () {
//     return {
//       keyword: "",
//     };
//   },
//   computed: {
//     isAuthenticated() {
//       return this.$store.getters.token != null;
//     },
//   },
//   methods: {
//     logout() {
//       return this.$store.dispatch("logout");
//     },
//   },
// }
</script>

<style scoped>
</style>