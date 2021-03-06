import Vue from "vue";
import Vuetify from "vuetify";

import es from "vuetify/es5/locale/es";

import "vuetify/dist/vuetify.min.css";
// import '@mdi/font/css/materialdesignicons.css'

Vue.use(Vuetify);

// https://vuetifyjs.com/en/features/icons/#reusable-custom-icons
// https://github.com/vuetifyjs/vuetify/blob/master/packages/vuetify/src/services/icons/presets/mdi-svg.ts

import {
  mdiAccount,
  mdiAccountCircle,
  mdiCogOutline,
  mdiAccountGroup,
  mdiPlus,
  mdiExitToApp,
  mdiChevronDown,
  mdiChevronLeft,
  mdiChevronRight,
  mdiFileFind,
  mdiPencil,
  mdiDelete,
  mdiDeleteOutline,
  mdiDeleteForever,
  mdiDeleteRestore,
  mdiFilterRemoveOutline,
  mdiFilter,
  mdiFilterMenu,
  mdiTextBoxMultipleOutline,
  mdiEye,
  mdiArchiveArrowDown,
  mdiArchiveArrowUp,
  mdiAccountPlus,
  mdiAccountMinus,
  mdiMenuDown,
  mdiSkipNext,
  mdiCheck,
  mdiFaceRecognition,
  mdiWeatherWindy,
  mdiMicrophone,
  mdiMagnify
} from "@mdi/js";

export default new Vuetify({
  lang: {
    locales: { es },
    current: "es"
  },
  icons: {
    // iconfont: 'mdi', // default - only for display purposes
    iconfont: "mdiSvg",
    values: {
      account: mdiAccount,
      accountCircle: mdiAccountCircle,
      cogOutline: mdiCogOutline,
      accountGroup: mdiAccountGroup,
      exitToApp: mdiExitToApp,
      plus: mdiPlus,
      chevronDown: mdiChevronDown,
      chevronLeft: mdiChevronLeft,
      chevronRight: mdiChevronRight,
      fileFind: mdiFileFind,
      pencil: mdiPencil,
      delete: mdiDelete, // Override
      deleteOutline: mdiDeleteOutline,
      deleteForever: mdiDeleteForever,
      deleteRestore: mdiDeleteRestore,
      filterRemoveOutline: mdiFilterRemoveOutline,
      filter: mdiFilter,
      filterMenu: mdiFilterMenu,
      textBoxMultipleOutline: mdiTextBoxMultipleOutline,
      eye: mdiEye,
      archiveArrowDown: mdiArchiveArrowDown,
      archiveArrowUp: mdiArchiveArrowUp,
      accountPlus: mdiAccountPlus,
      accountMinus: mdiAccountMinus,
      menuDown: mdiMenuDown,
      check: mdiCheck,
      skipNext: mdiSkipNext,
      faceRecognition: mdiFaceRecognition,
      weatherWindy: mdiWeatherWindy,
      microphone: mdiMicrophone,
      magnify: mdiMagnify
    }
  },
  theme: {
    themes: {
      light: {
        primary: "#00b1c7"
      }
    }
  }
});
