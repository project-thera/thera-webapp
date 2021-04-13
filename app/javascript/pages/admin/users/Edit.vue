<template>
  <div v-if="user">
    <h1>Editar usuario {{ user.username }}</h1>
    <Form :user="user" />
  </div>
</template>

<script>
import User from "@/resources/User";
import Form from "@/components/admin/users/Form";

export default {
  components: {
    Form
  },
  data() {
    return {
      user: null
    };
  },
  created() {
    User.includes("groups")
      .find(this.$route.params.id)
      .then(user => {
        this.user = user;
      });
  }
};
</script>
