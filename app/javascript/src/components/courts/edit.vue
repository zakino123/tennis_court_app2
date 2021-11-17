<template>
  <div class="container py-4 ">
    <div class="py-2 user-form mx-auto  border-2 bg-white shadow-md">
      <h1 class="text-2xl sm:text-3xl text-center py-4 font-bold">コート情報編集</h1>
      <div class="form-wide mx-auto">
        <label for="name" class="text-lg font-bold">施設名(テニスコート名)
        </label>
        <input type="text" v-model="name" id="name" class="mb-4 form-control" placeholder='施設名を入力して下さい。'/>

        <label for="address" class="text-lg font-bold">住所</label>
        <input type="text" v-model="address" id="address" class="mb-4 form-control" placeholder='住所を入力して下さい。'/>

        <input type="hidden" v-model="latitude" id="latitude">
        <input type="hidden" v-model="longitude" id="longitude">

        <label for="price" class="text-lg font-bold">1時間あたりの料金</label>
        <input type="number" v-model="price" id="price" class="mb-4 form-control" placeholder='数字を入力してください。'/>

        <label for="number" class="text-lg font-bold">コート数</label>
        <input type="number" v-model="number" id="number" class="mb-4 form-control" placeholder='コート数を入力して下さい。'/>

        <label for="reserve" class="text-lg font-bold">予約URL</label>
        <input type="text" v-model="reserve" id="reserve" class="mb-4 form-control" placeholder='予約URLを貼り付けてください。'/>

        <!-- <label for="tag_name" class="text-lg font-bold">タグ付け(半角スペースで複数可能)</label>
        <input type="text" v-model="tag_name" id="tag_name" class="mb-4 form-control" placeholder='例：オムニ 埼玉 クレー'/> -->

        <label for="remarks" class="text-lg font-bold">備考</label>
        <input type="text" v-model="remarks" id="remarks" class="mb-4 form-control" placeholder='他に何かあればご記入下さい。'/>

        <div class="text-center my-4">
          <button @click="editCourt()" class="inline-block text-gray-100 bg-blue-500 border border-yellow-500 hover:text-blue-500 hover:bg-white font-base px-4 py-2 rounded text-base">コート情報変更</button>
        </div>
        <div v-if="user_id === this.$store.state.userId" class="text-center my-2">
          <button type="button" @click="deleteCourt()" class="inline-block text-red-500 bg-gray-100 border-2 hover:text-gray-100 hover:bg-red-500 hover:shadow font-base px-4 py-2 rounded text-base">コート情報削除</button>
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
      address: "",
      latitude: "",
      longitude: "",
      price: "",
      number: "",
      reserve: "",
      // tag_name: "",
      remarks: "",
      user_id: "",
    };
  },
  created() {
    axios.get(`/api/v1/courts/${this.$route.params.id}`).then((response) => {
      this.name = response.data.name;
      this.address = response.data.address;
      this.latitude = response.data.latitude;
      this.longitude = response.data.longitude;
      this.price = response.data.price;
      this.number = response.data.number;
      // this.tag_name = response.data.tag_name;
      this.reserve = response.data.reserve;
      this.remarks = response.data.remarks;
      this.user_id = response.data.user_id;
      console.log(response);
    });
  },
  methods: {
    editCourt() {
      axios
        .put(`/api/v1/courts/${this.$route.params.id}`, {
          name: this.name,
          address: this.address,
          latitude: this.latitude,
          longitude: this.longitude,
          price: this.price,
          number: this.number,
          reserve: this.reserve,
          // tag_name: this.tag_name,
          remarks: this.remarks,
          user_id: this.$store.state.userId,
        })
        .then((response) => {
          console.log(response);
          this.$router.push(`/courts/${this.$route.params.id}`);
        })
        .catch((error) => {
          console.log(error);
          this.$router.push(`/courts/${this.$route.params.id}`);
        });
    },
    deleteCourt() {
      if (confirm("削除しますか？")) {
        axios
          .delete(`/api/v1/courts/${this.$route.params.id}`)
          .then((response) => {
            console.log(response);
            this.$router.push("/");
          })
          .catch((error) => {
            console.log(error);
            alert("失敗しました");
          });
      }
    },
  },
  
}
</script>

<style scoped>
</style>