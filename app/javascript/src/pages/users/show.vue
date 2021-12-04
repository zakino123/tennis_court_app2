<template>
  <div class="grid lg:grid-cols-4">
    <div class="user-info col-span-1 container mx-auto my-auto w-64">
      <div class="user-image justify-items-center mt-6 w-64 justify-center">
        <img
          v-if="user.image.url"
          :src="user.image.url"
          alt="ユーザーアイコン"
          width="200"
          height="200"
        />
        <img
          v-else
          src="../../assets/default.jpg"
          alt="ユーザーアイコン"
          width="200"
          height="200"
        />
        <div class="text-center text-gray-700 text-xl font-bold mt-3">
          {{ user.name }}さんのマイページ
        </div>
        <div class="text-center">
          <p class="text-xl h-6 mt-1">投稿数：{{ court_count }}</p>
        </div>
        <div class="text-center my-2 flex">
          <p class="text-gray-100 bg-indigo-500 border border-yellow-500 hover:text-indigo-400 hover:bg-white font-base rounded px-3 py-2 text-base mx-2" >フォロー{{ follow_count }}</p>
          <router-link :to="{ name: 'FollowerIndex', params: { id: user.id } }" class="text-gray-100 bg-indigo-500 border border-yellow-500 hover:text-indigo-400 hover:bg-white font-base rounded px-2 py-2 text-base mx-2">フォロワー{{ follower_count }}</router-link>
        </div>
        <div v-if="isAuthenticated && user.id != this.$store.state.userId" class="text-center my-3">
          <div v-if="UserFollowing">
            <input type="hidden" v-model="following_id" id="following_id"/>
            <button @click="UserUnFollow()" class="inline-block text-gray-100 bg-red-500 border border-yellow-500 hover:text-red-500 hover:bg-white font-base px-4 py-2 rounded text-base">フォロー解除</button>
          </div>
          <div v-else>
            <input type="hidden" v-model="following_id" id="following_id"/>
            <button @click="UserFollow()" class="inline-block text-gray-100 bg-yellow-400 border border-yellow-400 hover:text-yellow-500 hover:bg-white font-base px-4 py-2 rounded text-base">フォロー</button>
          </div>
        </div>
        <div v-if="user.id === this.$store.state.userId" class="text-center my-2">
          <router-link v-if="user.id === this.$store.state.userId"
          :to="{ name: 'UserEdit', params: { id: this.$store.state.userId } }" class="inline-block text-gray-100 bg-green-500 border border-yellow-500 hover:text-green-500 hover:bg-white font-base px-4 py-2 rounded text-base">ユーザー情報編集</router-link>
        </div>
      </div>
    </div>
    <div class="lg:col-span-3 mb-4 lg:mt-4">
      <UserFavoriteCourt></UserFavoriteCourt>
      <UserPostCourt></UserPostCourt>
    </div>
</div>
</template>

<script>
import axios from "axios";
import UserFavoriteCourt from "../../components/users/UserFavoriteCourt.vue";
import UserPostCourt from "../../components/users/UserPostCourt.vue";

export default {
  components: {
    UserFavoriteCourt, UserPostCourt
  },
  data() {
    return {
      user: [],
      court_count: "",
      follow: [],
      follow_count: "",
      follower_count: ""
    };
  },
  mounted() {
    axios.get(`/api/v1/users/${this.$route.params.id}`).then((response) => {
      this.user = response.data;
      console.log(response);
    });
    axios.get(`/api/v1/court_count/${this.$route.params.id}`).then((response) => {
      this.court_count = response.data;
      console.log(response);
    });
    axios
      .get(`/api/v1/follower/${this.$store.state.userId}/following/${this.$route.params.id}/follow`)
      .then(response => (this.follow = response.data))
    axios
      .get(`/api/v1/follow_count/${this.$route.params.id}`)
      .then(response => (this.follow_count = response.data))
    axios
      .get(`/api/v1/follower_count/${this.$route.params.id}`)
      .then(response => (this.follower_count = response.data))
  },
  methods: {
    UserFollow() {
      axios
        .post(`/api/v1/follow_relationships`, {
          follower_id: this.$store.state.userId,
          following_id: this.user.id
        })
        .then((response) => {
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    UserUnFollow() {
      axios
        .delete(`/api/v1/follower/${this.$store.state.userId}/following/${this.user.id}/unfollow`)
        .then((response) => {
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
          alert("失敗しました");
        });
    },
  },
  computed: {
    isAuthenticated() {
      return this.$store.getters.password_digest != null;
    },
    UserFollowing() {
      if (this.follow != null){
        return this.follow.follower_id === this.$store.state.userId
      }
    }
  },
}
</script>