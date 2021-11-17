<template>
  <div class="container py-4 ">
    <div class="py-2 user-form mx-auto  border-2 bg-white shadow-md">
      <h1 class="text-2xl sm:text-3xl text-center py-4 font-bold">ユーザー情報変更</h1>
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
          <div>
            <button @click="checkForm()" class="inline-block text-gray-100 bg-blue-500 border border-yellow-500 hover:text-blue-500 hover:bg-white font-base px-4 py-2 rounded text-base">変更</button>
          </div>
        </div>
        <div v-if="id === this.$store.state.userId" class="text-center my-2">
          <button @click="deleteUser()" class="inline-block text-red-500 bg-gray-100 border-2 hover:text-gray-100 hover:bg-red-500 hover:shadow font-base px-4 py-2 rounded text-base">ユーザー削除</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data: function () {
    return {
      id: "",
      name: "",
      email: "",
      password: "",
      password_confirmation: "",
      image: "",
    };
  },
  created() {
    axios.get(`/api/v1/users/${this.$route.params.id}`).then((response) => {
      this.id = response.data.id;
      this.name = response.data.name;
      this.email = response.data.email;
      this.password = response.data.password;
      this.password_confirmation = response.data.password_confirmation;
      console.log(response);
    });
  },
  methods: {
    updateUser() {
      axios
        .put(`/api/v1/users/${this.$route.params.id}`, {
          name: this.name,
          email: this.email,
          password: this.password,
          password_confirmation: this.password_confirmation,
        })
        .then((response) => {
          console.log(response);
          this.$router.push(`/users/${this.$route.params.id}`);
        })
        .catch((error) => {
          console.log(error);
          this.$router.push(`/users/${this.$route.params.id}`);
        });
    },
    checkForm: function (e) {
      if (this.password) {
        this.updateUser();
      }
      console.log("パスワードを入力して下さい");
    },
    deleteUser() {
      if (confirm("削除しますか？")) {
        axios
          .delete(`/api/v1/users/${this.$route.params.id}`)
          .then((response) => {
            console.log(response);
            this.logoutUser();
          })
          .catch((error) => {
            console.log(error);
            alert("失敗しました");
          });
      }
    },
    logoutUser() {
      this.$store.state.userId = null;
      this.$store.state.password_digest = null;
      this.$router.push("/login");
    },
  },
};
</script>

<style scoped>
</style>