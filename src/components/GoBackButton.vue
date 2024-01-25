<script lang="ts">
import { defineComponent } from "vue";
import { Router } from "vue-router";

export default defineComponent({
  name: "GoBackButton",
  methods: {
    goBack(this: { $router: Router }) {
      this.$router.push("/");
    },
  },
});
</script>

<template>
  <img
    src="img/icons/arrow-left.svg"
    alt="Arrow left"
    class="arrow"
    @click="goBack"
  />
</template>

<style lang="scss">
@import "@/assets/mixins.scss";

.arrow {
  width: 24px;
  height: 24px;
  cursor: pointer;

  @include onPhone {
    width: 20px;
    height: 20px;
  }
}
</style>
