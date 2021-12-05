<template>
  <div class="container pb-4">
    <div class="text-center">
      <h1 class="text-2xl sm:text-3xl text-center py-4">フォロワー一覧</h1>
    </div>
    <ul class="mb-2 mx-auto grid gap-x-2 gap-y-4 grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
      <li v-for="e in users" :key="e.id"  class="mt-2 mx-auto bg-green-100 hover:bg-white border-2 border-gray-300 px-4 pt-2 list-none hover:shadow card">
        <img
          v-if="e.image.url"
          :src="e.image.url"
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
        <div class="text-center">
          <router-link :to="{ name: 'UserShow', params: { id: e.id } }" class="font-bold underline mt-2 hover:text-green-600">{{ e.name }}</router-link>
          <!-- <p class="text-xl h-6 mt-1">投稿数：<%= user.courts.count %></p> -->
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      users: []
    }
  },
  mounted () {
    axios
      .get(`/api/v1/users/${this.$route.params.id}/followers`)
      .then(response => (this.users = response.data))
  },
}
</script>