<template>
  <div class="text-center">
    <h2 class="text-3xl pt-3">テニスコート検索</h2>
    <h3 class="text-2xl m-1 border-b-2 border-black">〜最適なテニスコートをあなたへ〜</h3>
    <div class="mt-3">
      <input type="text" v-model="location" class="bg-gray-200 mr-2 hover:bg-white hover:border-gray-300 focus:outline-none focus:bg-white focus:shadow-outline focus:border-gray-300 w-1/3 h-10" placeholder="住所や行きたい場所を入力してください。" />
      <select v-model="keyword" class='bg-gray-200 hover:bg-white mr-2 hover:border-gray-300 focus:outline-none focus:bg-white focus:shadow-outline focus:border-gray-300 w-1/4 h-10'>
        <option v-for="option in options" v-bind:key="option.value">
            {{ option.name }}
        </option>
      </select>
      <button @click="search()" class="bg-red-100 hover:bg-red-200 hover:border-gray-300 w-1/12 h-10 font-bold">検索</button>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      location: '',
      keyword:'Near',
      options: [
        { value: 'Near', name: '距離が近い順' },
        { value: 'inexpensive', name: '1時間当たりのコート料金が安い順' },
        { value: 'number', name: 'コート数が多い順' }
      ]
    };
  },
  computed: {
    isAuthenticated() {
      return this.$store.getters.token != null;
    },
  },
  methods: {
    logout() {
      return this.$store.dispatch("logout");
    },
    search() {
      return this.$store.dispatch("search", {
        searchWord: this.location,
      });
    },
  },
}
</script>