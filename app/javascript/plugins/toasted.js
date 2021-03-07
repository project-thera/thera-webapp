import Vue from "vue";
import Toasted from "vue-toasted";

const toast = window.addEventListener("load", function() {
  Vue.use(Toasted, {
    position: "bottom-right",
    duration: 5000,
    iconPack: "mdi",
    action: {
      icon: "close",
      onClick: (e, toastObject) => {
        toastObject.goAway(0);
      },
    },
  });
});

export default toast;
