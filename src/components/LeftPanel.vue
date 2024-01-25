<script lang="ts">
import { defineComponent } from "vue";
import { Router } from "vue-router";

export default defineComponent({
  name: "LeftPanel",
  methods: {
    navigateToHomePage(this: { $router: Router }) {
      this.$router.push({ name: "home" });
    },
  },
});
</script>

<template>
  <router-link to="/" class="left-panel">
    <img src="img/icons/logo.svg" alt="Logo" class="left-panel-logo" />
  </router-link>
</template>

<style lang="scss" scoped>
.left-panel {
  position: fixed;
  top: 0;
  left: 0;
  width: 40px;
  height: 100vh;
  background-color: rgba(98, 123, 122, 1);

  &-logo {
    width: 24px;
    height: 24px;
    margin: 9px auto 0;
  }
}
</style>
