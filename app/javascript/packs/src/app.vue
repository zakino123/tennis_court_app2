<template>
  <div id="app">
    <Header></Header>
    <router-view></router-view>
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
