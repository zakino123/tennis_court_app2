<template>
  <div class="container py-4 ">
    <div class="py-2 user-form mx-auto  border-2 bg-white shadow-md">
      <h1 class="text-2xl sm:text-3xl text-center py-4 font-bold">ログイン</h1>
      <div class="form-wide mx-auto">
        <label for="email" class="text-lg font-bold">メールアドレス</label>
        <input type="email" v-model="email" id="email" class="mb-4 form-control" placeholder='メールアドレスを入力してください。'/>

        <label for="password" class="text-lg font-bold">パスワード</label>
        <input type="password" v-model="password" id="password" class="mb-4 form-control" placeholder='半角英数字6文字以上'/>

        <div class="text-center my-4">
          <div v-if="email && password">
            <button @click="login()" class="inline-block text-gray-100 bg-green-500 border border-yellow-500 hover:text-green-500 hover:bg-white font-base px-4 py-2 rounded text-base">ログイン</button>
          </div>
          <div v-else>
            <button class="opacity-30 text-gray-100 bg-green-500 border border-yellow-500 font-base px-4 py-2 rounded text-base">ログイン</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      password: "",
    };
  },
  // methods: {
  //   login() {
  //     this.$store.dispatch("login", {
  //       email: this.email,
  //       password: this.password,
  //     });
  //   },
  // },
};
</script>


<style scoped>
</style>