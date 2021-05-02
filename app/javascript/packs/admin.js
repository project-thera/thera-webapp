// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
// require("@rails/activestorage").start()
// require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import Vue from "vue";

import App from "@/components/admin/App";

import { abilitiesPlugin } from "@casl/vue";
import defineAbilityFor from "@/services/ability";
import axios from "@/plugins/axios";
import fragment from "@/plugins/fragment";
import vuetify from "@/plugins/vuetify";
import store from "@/plugins/store";
import toast from "@/plugins/toasted";

import "@/plugins/bus";
import "@/plugins/casl";
import "@/plugins/date";
import "@/plugins/moment";
import "@/plugins/portal";
import "@/plugins/vee-validate";
import "@/plugins/vue-horizontal";
import "@/plugins/base64encode";

import i18n from "@/plugins/admin/i18n";
import routes from "@/plugins/admin/routes";
import "@/plugins/admin/autoloading";

import "@/assets/favicon.ico";

// Use packages
Vue.config.productionTip = false;
Vue.prototype.$axios = axios;

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("app");
  const currentUser = JSON.parse(container.dataset.currentUser);
  const abilities = defineAbilityFor(currentUser);

  Vue.prototype.$serverParameters = JSON.parse(container.dataset.parameters);

  store.commit("user/setCurrentUser", currentUser);

  Vue.use(abilitiesPlugin, abilities);

  routes.beforeEach((to, from, next) => {
    const canNavigate = to.matched.some(route => {
      return (
        abilities.can(route.meta.action || "index", route.meta.resource) ||
        route.meta.resource == undefined
      );
    });

    if (!canNavigate) {
      return next("/");
    }

    next();
  });

  const app = new Vue({
    vuetify,
    toast,
    fragment,
    i18n,
    router: routes,
    store: store,
    render: h => h(App)
  }).$mount("#app");

  document.body.appendChild(app.$el);
});
