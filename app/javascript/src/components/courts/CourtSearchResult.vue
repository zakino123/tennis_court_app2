<template>
  <div>
    <SearchForm></SearchForm>
    <div class="text-center">
      <h1 class="text-2xl sm:text-3xl text-center my-10">検索結果<br><span class="text-lg sm:text-2xl border-b-2 border-black">(検索ワードの地点から半径10km以内を表示)</span></h1>
    </div>
    <div class="container py-4 ">
      <ul class="mb-2 mx-auto grid gap-x-2 gap-y-4 grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
        <li v-for="e in search_courts" :key="e.id" class="bg-green-100 mx-auto hover:bg-white border-2 border-gray-300 px-4 pt-2 list-none hover:shadow card">
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
            <p class="text-xl h-6 mt-1">料金:{{ e.price }}円/時間</p>
            <div class="mt-2">
              <!-- <span><i class="fas fa-star fa-lg fill-current text-yellow-500"></i>{{ e.favorite.count }}</span> -->
              <span class="font-bold underline"><i class="far fa-user mr-2"></i>{{ e.user.name }}</span>
            </div>
            <p class="text-xl h-6 mt-1">コート数:{{ e.number }}面</p>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import SearchForm from './searchform.vue'

export default {
  components: {
    SearchForm
  },
  data: function () {
    return {
      search_courts: [],
    };
  },
  created() {
    this.renderResearchResult();
  },
  methods: {
    renderResearchResult: function () {
      axios
        // .get(`/api/v1/courts/search/${this.$store.state.searchWord}/${this.$store.state.searchSelection}`)
        .get(`/api/v1/courts/search/${this.$store.state.searchWord}/`)
        .then((response) => {
          this.search_courts = response.data;
          console.log(response.data);
        });
    },
  },
  mounted() {
    this.$store.watch(
      () => this.$store.state.searchWord,
      // () => this.$store.state.searchSelection,
      () => {
        this.renderResearchResult();
      }
    );
  },
}
</script>

<style scoped>
</style>