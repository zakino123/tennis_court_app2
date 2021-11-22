<template>
  <div>
    <h2 class="text-2xl text-center font-bold mb-4">お気に入りコート</h2>
    <div v-if="existFavoriteCourt">
      <ul class="mb-2 mx-auto grid gap-x-2 gap-y-4 grid-cols-1 sm:grid-cols-2 md:grid-cols-3">
        <li v-for="e in favorite_court" :key="e.id" class="bg-green-100 mx-auto hover:bg-white border-2 border-gray-300 px-4 pt-2 list-none hover:shadow card">
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
    <div v-else>
      <p class="text-lg sm:text-2xl text-center">該当のコートはありません。</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      favorite_court: []
    }
  },
  mounted () {
    axios
      .get(`/api/v1/favorite_court/${this.$route.params.id}`)
      .then(response => (this.favorite_court = response.data))
  },
  computed: {
    existFavoriteCourt() {
      return this.favorite_court != null;
    },
  },
}
</script>

<style scoped>
</style>