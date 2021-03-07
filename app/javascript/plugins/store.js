import Vue from "vue";
import Vuex from "vuex";
import filters from "@/store/filters";
import user from "@/store/UserStore";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    user,
    filters,
  },
});
