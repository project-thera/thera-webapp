import Vue from "vue";

const INITIAL_STATE = { page: 1 };

export default {
  namespaced: true,
  state: {
    adminExercises: INITIAL_STATE,
    adminGroups: INITIAL_STATE,
    adminUsers: INITIAL_STATE,
    adminPatients: INITIAL_STATE
  },
  mutations: {
    add(state, { key, filters }) {
      // Check if needs reset
      if (filters._clear == true || filters._clear == "true") {
        Vue.set(state, key, INITIAL_STATE);

        return;
      }

      // Clean empty filters
      for (const propName in filters) {
        if (
          filters[propName] === null ||
          filters[propName] === undefined ||
          filters[propName] === ""
        ) {
          delete filters[propName];
        }
      }

      // Parse page if string or initialize
      if (Object.entries(filters).length !== 0) {
        let { page, ...filter } = filters;

        if (page != null) {
          page = parseInt(page);
        } else {
          page = 1;
        }

        Vue.set(state, key, { page, ...filter });
      }
    },
    clear(state, key) {
      Vue.set(state, key, INITIAL_STATE);
    }
  },
  actions: {
    add({ commit }, payload) {
      commit("add", payload);
    },
    page({ commit }, payload) {
      commit("page", payload);
    },
    clear({ commit }, key) {
      commit("clear", key);
    }
  }
};
