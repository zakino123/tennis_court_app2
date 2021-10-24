<template>
  <div>
    <SearchForm></SearchForm>
    <div class="text-center">
      <h1 class="text-2xl sm:text-3xl text-center my-10">検索結果<br><span class="text-lg sm:text-2xl border-b-2 border-black">(検索ワードの地点から半径10km以内を表示)</span></h1>
    </div>
    <div v-show = "create">
    <div v-if="questions.length != 0">
      <div class="grid grid-cols-12">
        <div class="col-span-2"></div>
        <div class="col-span-8">
          <div
            class="
              flex
              items-center
              my-2
              rounded
              justify-between
              p-3
              bg-green-100
            "
          >
            <span class="rounded-lg p-2 bg-white"> </span>
            <div class="flex w-full ml-2 items-center justify-between">
              「{{ this.$store.state.searchWord }}」の検索結果:{{
                questions.length
              }}件
            </div>
          </div>
          <question-base :questions="questions"></question-base>
        </div>
        <div class="col-span-2"></div>
      </div>
    </div>
    <div v-else>
      <h1 class="text-center mt-6">
        「{{ this.$store.state.searchWord }}」に関する質問はまだ投稿されていません
      </h1>
    </div>
  </div>
  </div>
</template>

<script>
// import axios from "axios";
// import CourtResult from "../../components/courts/result.vue";
import SearchForm from '../../components/courts/searchform.vue'

export default {
  components: {
    SearchForm//, CourtResult
  },
  // created() {
  //   this.renderResearchResult();
  // },
  // methods: {
  //   renderResearchResult: function () {
  //     axios
  //       .get(`api/v1/questions/search/${this.$store.state.searchWord}`)
  //       .then((response) => {
  //         this.questions = response.data;
  //         this.create = true
  //         console.log(response.data);
  //       });
  //   },
  // },
  // mounted() {
  //   this.$store.watch(
  //     () => this.$store.state.searchWord,
  //     () => {
  //       this.renderResearchResult();
  //     }
  //   );
  // },
}
</script>

<style scoped>
</style>