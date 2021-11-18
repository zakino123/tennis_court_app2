<template>
  <div class="mt-3">
    <h2 class="text-2xl">タグリスト</h2>
    <span v-for="e in taglist" :key="e.id">
      <router-link :to="{ name: 'TagSearchResult', params: { id: e.id } }" class="inline-block my-2 px-3 py-1 border-2 border-indigo-500 rounded-full font-semibold cursor-pointer hover:text-white hover:bg-indigo-500">{{ e.tag_name }}</router-link>
    </span>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      taglist: []
    }
  },
  mounted () {
    axios
      .get('/api/v1/taglist')
      .then(response => (this.taglist = response.data))
  },
}
</script>