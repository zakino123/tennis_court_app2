<template>
  <div id="app">
    <Header></Header>
    <div class="bg-gray-100">
      <router-view></router-view>
    </div>
    <Footer></Footer>
  </div>
</template>

<script>
import Header from './components/layouts/header.vue'
import Footer from './components/layouts/footer.vue'

export default {
  name: 'MyApp',
  components: {
    Header,Footer
  }
}
</script>

<style scoped>
</style>
