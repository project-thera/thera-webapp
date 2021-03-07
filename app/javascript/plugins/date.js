import Vue from "vue";

Vue.prototype.$formatDate = function(date) {
  if (!date) return null;
  return this.$moment(date, "YYYY-MM-DD").format("DD/MM/YYYY");
};

Vue.prototype.$parseDate = function(date) {
  if (!date) return null;
  return this.$moment(date, "DD/MM/YYYY").format("YYYY-MM-DD");
};

Vue.prototype.$formatDatetime = function(datetime) {
  if (!datetime) return null;
  return this.$moment(datetime).format("DD/MM/YYYY HH:mm:ss");
};

Vue.prototype.$fromNow = function(datetime) {
  if (!datetime) return null;
  return this.$moment(datetime).fromNow();
};

Vue.prototype.$minifyUpdatedAt = function(datetime) {
  if (!datetime) return null;

  if (this.$moment().isSame(datetime, "year")) {
    if (this.$moment().isSame(datetime, "day")) {
      return this.$moment(datetime).format("HH:mm");
    }

    return this.$moment(datetime).format("D MMM");
  }

  return this.$moment(datetime).format("DD/MM/YY");
};
