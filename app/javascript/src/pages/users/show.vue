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
        <!-- <div class="text-center">
          <p class="text-xl h-6 mt-1">投稿数：{{ user.courts.count }}</p>
        </div>
        <div class="text-center my-2 flex">
          <a href="following_user_path(@user)" class="text-gray-100 bg-indigo-500 border border-yellow-500 hover:text-indigo-400 hover:bg-white font-base rounded px-3 py-2 text-base mx-2" >フォロー{{user.followings.count}}</a>
          <a href=followers_user_path(@user) class="text-gray-100 bg-indigo-500 border border-yellow-500 hover:text-indigo-400 hover:bg-white font-base rounded px-2 py-2 text-base mx-2">フォロワー{{ user.followers.count }}</a>
        </div> -->
        <div v-if="isAuthenticated && user.id != this.$store.state.userId" class="text-center my-3">
          <div v-if="UserFollowing">
            <input type="hidden" v-model="following_id" id="following_id"/>
            <button @click="UserFollow()" class="inline-block text-gray-100 bg-yellow-400 border border-yellow-400 hover:text-yellow-500 hover:bg-white font-base px-4 py-2 rounded text-base">フォロー</button>
          </div>
          <div v-else>
            <input type="hidden" v-model="following_id" id="following_id"/>
            <button @click="UserUnFollow()" class="inline-block text-gray-100 bg-red-500 border border-yellow-500 hover:text-red-500 hover:bg-white font-base px-4 py-2 rounded text-base">フォロー解除</button>
          </div>
        </div>
        <!-- <% if logged_in? && @user != current_user%>
          <div id="follow_form" class="text-center my-3">
            <% if current_user.following?(@user) %>
              <%= render "unfollow" %>
            <% else %>
              <%= render "follow" %>
            <% end %>
          </div>
        <% end %> -->
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
    };
  },
  mounted() {
    axios.get(`/api/v1/users/${this.$route.params.id}`).then((response) => {
      this.user = response.data;
      console.log(response);
    });
  },
  methods: {
    UserFollow() {
      axios
        .post(`/api/v1/courts/${this.court.id}/favorites`, {
          following_id: this.this.$store.state.userId,
        })
        .then((response) => {
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    Userunfollow() {
      axios
        .delete(`/api/v1/court/${this.court.id}/user/${this.$store.state.userId}/favorite`)
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

    }
  },
}
</script>