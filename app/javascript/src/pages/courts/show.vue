<template>
  <div>
    <div class="container">
      <div class="text-center">
        <h1 class="text-3xl sm:text-4xl text-center py-4">施設情報</h1>
      </div>
      <div class="grid sm:grid-cols-2 gap-6 mt-4">
        <div class="col-span-1">
          <div class="mt-2">
            <h2 class="font-bold mb-2 text-4xl">{{ court.name }}</h2>
            <span>タグ:</span>
            <span v-for="e in court_tags" :key="e.id">
              <router-link :to="{ name: 'TagSearchResult', params: { id: e.id } }" class="inline-block my-2 px-3 py-1 border-2 border-indigo-500 rounded-full font-semibold cursor-pointer hover:text-white hover:bg-indigo-500">{{ e.tag_name }}</router-link>
            </span>
          </div>
          <div class="mb-4">
            <p>ユーザー：<router-link :to="{ name: 'UserShow', params: { id: this.court.user_id } }" class="hover:underline">{{ court.user.name }}</router-link></p>
          </div>
          <div class="flex mb-2">
            <div class='flex star-btn mt-1 mr-2 border-2 border-yellow-400 bg-red-100 hover:bg-white rounded'>
              <div v-if="isAuthenticated">
                <div v-if="isFavorited">
                  <button @click="destroyFavorite()"><i class="m-2 fas fa-star fa-lg fill-current text-yellow-400"></i></button>
                  <span class="my-auto pr-1">{{ count }}</span>
                  <span class="my-auto pr-2">保存</span>
                </div>
                <div v-else>
                  <button @click="createFavorite()"><i class="m-2 fas fa-star fa-lg fill-current text-gray-700"></i></button>
                  <span class="my-auto pr-1">{{ count }}</span>
                  <span class="my-auto pr-2">保存</span>
                </div>
              </div>
              <div v-else>
                <span class="my-auto pr-2">ログイン後、お気に入り登録可能です。</span>
              </div>
            </div>
            <router-link
              v-if="court.user_id === this.$store.state.userId"
              :to="{ name: 'CourtEdit', params: { id: court.id } }" 
              class="inline-block text-gray-100 bg-green-500 border border-yellow-500 hover:text-green-500 hover:bg-white font-base px-4 py-2 rounded text-base">
              コート情報変更
            </router-link>
          </div>
          <img size='1000x1000' class='border-2' v-if="court.image.url" :src="court.image.url"/>
          <img size='1000x1000' class='border-2' v-else src="../../assets/default_court.png"/>
          <div class="text-center my-2">
            <button class="inline-block text-gray-100 bg-pink-500 border border-yellow-500 hover:text-pink-500 hover:bg-white font-base px-4 py-2 rounded text-base"><a :href="court.reserve">予約サイトへGo!</a></button>
          </div>
        </div>
        <div class="col-span-1 my-auto">
          <h2 class="text-center font-bold mb-2 text-2xl xl:text-3xl">コート情報</h2>
          <table class="border-2 shadow-md bg-white mx-auto text-sm md:text-lg lg:text-xl xl:text-2xl">
            <tr class="border-2">
              <th class="py-2 font-bold border-r-2">料金</th>  <th class="pl-2">{{ court.price }}円/1時間</th>
            </tr>
            <tr class="border-2">
              <th class="py-2 font-bold border-r-2">コート数</th><th class="pl-2">{{ court.number }}面</th>
            </tr>
            <tr class="border-2">
              <th class="py-2 font-bold border-r-2">住所</th><th class="pl-2">{{ court.address }}</th>
            </tr>
            <tr class="border-2">
              <th class="py-2 font-bold border-r-2">目的地まで</th>
              <th>
                <button class="button"><a :href="'https://www.google.com/maps/search/?api=1&query=' + court.latitude + ',' + court.longitude" class="font-bold pl-2 underline text-red-400">GoogleMapでルートを検索</a></button>
              </th>
            </tr>
            <tr class="border-2">
              <th class="py-2 font-bold border-r-2">マップ確認</th>
              <th id="map"></th>
            </tr>
            <tr class="border-2">
              <th class="py-2 font-bold border-r-2">備考</th>
              <th v-if="court.remarks" class="pl-2">{{ court.remarks }}</th>
              <th v-else class="pl-2">記載なし</th>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <div class="container py-2">
      <div class="col-md-8 mx-auto">
        <h3 class="font-bold text-xl mb-2">コメント： {{ comment_count }}件</h3>
        <div v-if="isAuthenticated">
          <div class="comment-form">
            <textarea type="text" v-model="context" id="context" rows="2" class="form-control mb-2"></textarea>
            <div class="text-center">
              <button @click="createComment()" class="inline-block text-gray-100 bg-green-500 border border-yellow-500 hover:text-green-500 hover:bg-white font-base px-4 py-2 rounded text-base mb-2">コメントする</button>
            </div>
          </div>
        </div>
        <div v-else>
          <h4>ログイン後、コメント可能になります。</h4>
        </div>
        <ol class="microposts">
          <li v-for="e in court_comment" :key="e.id" class="flex py-2 border-t-2 border-black border-b-2">
            <img width='100' class='border-2' v-if="e.user.image.url" :src="e.user.image.url"/>
            <img width='100' class='border-2' v-else src="../../assets/default.jpg"/>
            <div class="ml-2 my-auto">
              <div class="user">
                <router-link :to="{ name: 'UserShow', params: { id: e.user_id } }" class="hover:underline">{{ e.user.name }}</router-link>
                <span class="timestamp">
                  <p>{{ moment(e.created_at) }}に投稿</p>
                </span>
              </div>
              <p class="content">{{ e.context }}</p>
              <span v-if="e.user_id === $store.state.userId">
                <button @click="deleteComment()" class="text-red-500 hover:text-red-700">削除</button>
              </span>
            </div>
          </li>
        </ol>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";

export default {
  data() {
    return {
      court: [],
      count: "",
      favorite: [],
      court_tags: [],
      comment_count: "",
      court_comment: []
    };
  },
  computed: {
    isAuthenticated() {
      return this.$store.getters.password_digest != null;
    },
    isFavorited() {
      if (this.favorite != null){
        return this.favorite.user_id === this.$store.state.userId
      }
    },
  },
  mounted() {
    axios.get(`/api/v1/courts/${this.$route.params.id}`).then((response) => {
      this.court = response.data;
      console.log(response);
    });
    axios
      .get(`/api/v1/favorite_count/${this.$route.params.id}`)
      .then(response => (this.count = response.data))
    axios
      .get(`/api/v1/court/${this.$route.params.id}/user/${this.$store.state.userId}/favorite`)
      .then(response => (this.favorite = response.data))
    axios
      .get(`/api/v1/court_tag/${this.$route.params.id}`)
      .then(response => (this.court_tags = response.data))
    axios
      .get(`/api/v1/comment_count/${this.$route.params.id}`)
      .then(response => (this.comment_count = response.data))
    axios
      .get(`/api/v1/court_comment/${this.$route.params.id}`)
      .then(response => (this.court_comment = response.data))
  },
  methods: {
    createFavorite() {
      axios
        .post(`/api/v1/courts/${this.court.id}/favorites`, {
          court_id: this.court.id,
          user_id: this.$store.state.userId,
        })
        .then((response) => {
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    destroyFavorite() {
      axios
        .delete(`/api/v1/court/${this.court.id}/user/${this.$store.state.userId}/favorite`)
        .then((response) => {
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
          alert("失敗しました");
        });
    },
    createComment() {
      axios
        .post(`/api/v1/courts/${this.court.id}//comments`, {
          court_id: this.court.id,
          user_id: this.$store.state.userId,
          context: this.context
        })
        .then((response) => {
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
          alert("失敗しました");
        });
    },
    deleteComment() {
      axios
        .delete(`/api/v1/court/${this.court.id}/user/${this.$store.state.userId}/comment`)
        .then((response) => {
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
          alert("失敗しました");
        });
    },
    moment: function(date) {
      moment.locale("ja");
      return moment(date).fromNow();
    },
  // initMap() {
  //   var test ={lat: court.latitude, lng: court.longitude};
  //   var map = new google.maps.Map(document.getElementById('map'), {
  //             zoom: 15, 
  //             center: test
  //             });
  //   var transitLayer = new google.maps.TransitLayer();
  //   transitLayer.setMap(map);

  //   var contentString = '住所：{{ court.address }}';
  //   var infowindow = new google.maps.InfoWindow({
  //     content: contentString
  //   });
  //   var marker = new google.maps.Marker({
  //                 position:test,
  //                 map: map,
  //                 title: contentString
  //               });

  //   marker.addListener('click', function() {
  //     infowindow.open(map, marker);
  //   });
  // },
  }
}
</script>

<style type="text/css">
  #map { height: 200px;
        width: 70%;}
</style>