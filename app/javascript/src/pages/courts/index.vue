<template>
  <div>
    <SearchForm></SearchForm>
    <div class="text-center">
      <h1 class="text-2xl sm:text-3xl text-center my-10">検索結果<br><span class="text-lg sm:text-2xl border-b-2 border-black">(検索ワードの地点から半径10km以内を表示)</span></h1>
    </div>
    <div class="container py-4 ">
      <h2 class="text-lg text-center font-bold mb-2">お気に入り数が多いコート</h2>
    </div>
    <div class="container py-4">
      <h2 class="text-lg text-center font-bold mb-2">最近投稿されたコート</h2>
    </div>
  </div>
</template>

<script>
import SearchForm from '../../components/courts/searchform.vue'

export default {
  name: 'global_login',
  components: {
    SearchForm
  }
}
</script>

<style scoped>
</style>