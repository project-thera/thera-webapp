<template>
  <div>
    <article>
      <h1 class="mb-2">
        {{ $t("views.users.new.title") }}
      </h1>

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
