<template>
  <div class="container py-4 ">
    <div class="py-2 user-form mx-auto  border-2 bg-white shadow-md">
      <h1 class="text-2xl sm:text-3xl text-center py-4 font-bold">新規登録</h1>
      <div class="form-wide mx-auto">
        <label for="name" class="text-lg font-bold">ニックネーム
        </label>
        <input type="text" v-model="name" id="name" class="mb-4 form-control" placeholder='30文字以内で入力してください。'/>

        <label for="email" class="text-lg font-bold">メールアドレス</label>
        <input type="email" v-model="email" id="email" class="mb-4 form-control" placeholder='メールアドレスを入力してください。'/>

        <label for="password" class="text-lg font-bold">パスワード</label>
        <input type="password" v-model="password" id="password" class="mb-4 form-control" placeholder='半角英数字6文字以上'/>

        <label for="password_confirmation" class="text-lg font-bold">パスワード(確認)</label>
        <input type="password" v-model="password_confirmation" id="password_confirmation" class="mb-4 form-control" placeholder='半角英数字6文字以上'/>

        <div class="text-center my-4">
          <div v-if="name && email && password && password_confirmation">
            <button @click="register()" class="inline-block text-gray-100 bg-blue-500 border border-yellow-500 hover:text-blue-500 hover:bg-white font-base px-4 py-2 rounded text-base">ユーザー登録</button>
          </div>
          <div v-else>
            <button class="opacity-30 text-gray-100 bg-blue-500 border border-yellow-500 font-base px-4 py-2 rounded text-base">ユーザー登録</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  data() {
    return {
      name: "",
      email: "",
      password: "",
      password_confirmation: "",
      image: "",
    };
  },
  methods: {
    register() {
      axios
        .post("/api/v1/users", {
          name: this.name,
          email: this.email,
          password: this.password,
          password_confirmation: this.password_confirmation,
          image: this.image,
        })
        .then((response) => {
          console.log(response);
          this.login();
        })
        .catch((error) => {
          console.log(error);
        });
    },
    // closeAlert: function () {
    //   this.alertOpen = false;
    // },
    login() {
      this.$store.dispatch("login", {
        email: this.email,
        password: this.password,
      });
    },
  },
}
</script>

<style scoped>
</style>