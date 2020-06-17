import Vue from "vue";
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import "@mdi/font/css/materialdesignicons.css";
import App from "./App.vue";

Vue.use(Vuetify)

new Vue({
    el: "#app",
    vuetify: new Vuetify(),
    render: h => h(App)
});