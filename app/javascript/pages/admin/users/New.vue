<template>
  <div>
    <article>
      <h2 class="mb-2 text-uppercase">
        {{ $t("views.users.new.title") }}
      </h2>

      <Form />
    </article>
  </div>
</template>

<script>
import Form from "@/components/admin/users/Form";

export default {
  components: {
    Form
  }
};
</script>
