<template>
  <div>
    <SearchForm></SearchForm>
    <div class="text-center">
      <h1 class="text-2xl sm:text-3xl text-center my-10">検索結果<br><span class="text-lg sm:text-2xl border-b-2 border-black">(検索ワードの地点から半径10km以内を表示)</span></h1>
    </div>
    <AllRank></AllRank>
    <LatestCourt></LatestCourt>
  </div>
</template>

<script>
import SearchForm from '../../components/courts/searchform.vue'
import AllRank from '../../components/courts/AllRank.vue'
import LatestCourt from '../../components/courts/LatestCourt.vue'

export default {
  components: {
    SearchForm, AllRank, LatestCourt
  }
}
</script>

<style scoped>
</style>