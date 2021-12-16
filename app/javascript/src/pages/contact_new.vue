<template>
  <div class="container py-4">
    <div class="py-2 user-form mx-auto  border-2 bg-white shadow-md">
      <h1 class="text-2xl sm:text-3xl text-center py-4 font-bold">お問合せフォーム</h1>
      <div class="form-wide mx-auto">
        <label for="name" class="text-lg font-bold">名前</label>
        <input type="text" v-model="name" id="name" class="mb-4 form-control" placeholder='30文字以内で入力してください。'/>

        <label for="email" class="text-lg font-bold">メールアドレス</label>
        <input type="email" v-model="email" id="email" class="mb-4 form-control" placeholder='メールアドレスを入力してください。'/>

        <label for="message" class="text-lg font-bold">お問合せ内容</label>
        <input type="text" v-model="message" id="message" class="mb-4 form-control" placeholder='お問合せ内容をご入力下さい。'/>

        <div class="text-center my-4">
          <div v-if="name && email && message">
            <button @click="contact()" class="inline-block text-gray-100 bg-green-500 border border-yellow-500 hover:text-green-500 hover:bg-white font-base px-4 py-2 rounded text-base">送信</button>
          </div>
          <div v-else>
            <button class="opacity-30 text-gray-100 bg-green-500 border border-yellow-500 font-base px-4 py-2 rounded text-base">送信</button>
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
      message: "",
    };
  },
  methods: {
    contact() {
      axios
        .post("/api/v1/contacts", {
          name: this.name,
          email: this.email,
          message: this.message,
        })
        .then((response) => {
          console.log(response);
          this.$router.push("/");
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
}
</script>

<style scoped>
</style>