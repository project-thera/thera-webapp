import Vue from "vue";
import VueI18n from "vue-i18n";
import esAR from "@/locales/admin_es-AR";

Vue.use(VueI18n);

export default new VueI18n({
  locale: "esAR",
  messages: esAR
});
