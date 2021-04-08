export default {
  namespaced: true,
  state: {
    currentUser: null
  },
  mutations: {
    setCurrentUser(state, currentUser) {
      state.currentUser = { ...currentUser };
    }
  }
};
