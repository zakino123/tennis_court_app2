<template>
  <div class="container py-4 ">
  <h2 class="text-lg text-center font-bold mb-2">お気に入り数が多いコート</h2>
    <ul class="mb-2 mx-auto grid gap-x-2 gap-y-4 grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
      <li v-for="e in court_rank" :key="e.id" class="bg-green-100 mx-auto hover:bg-white border-2 border-gray-300 px-4 pt-2 list-none hover:shadow card">
        <div class="text-center">
          <img
            v-if="e.image.url"
            :src="e.image.url"
            alt="コートアイコン"
            width="200"
            height="200"
          />
          <img
            v-else
            src="../../assets/default_court.png"
            alt="コートアイコン"
            width="200"
            height="200"
          />
          <router-link :to="{ name: 'CourtShow', params: { id: e.id } }" class="font-bold underline mt-2">{{ e.name }}</router-link>
          <p class="text-xl h-6 mt-1">料金：{{ e.price }}円/時間</p>
          <div class="mt-2">
            <!-- <span><i class="fas fa-star fa-lg fill-current text-yellow-500"></i>{{ e.favorite.count }}</span> -->
            <span class="font-bold underline"><i class="far fa-user mr-2"></i>{{ e.user.name }}</span>
          </div>
          <p class="text-xl h-6 mt-1">コート数：{{ e.number }}面</p>
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
      court_rank: []
    }
  },
  mounted () {
    axios
      .get('/api/v1/court_rank')
      .then(response => (this.court_rank = response.data))
  },
}
</script>

<style scoped>
</style>