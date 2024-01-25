<script lang="ts">
import { Router } from "vue-router";

export default {
  name: "LeftPanel",
  methods: {
    navigateToHomePage(this: { $router: Router }) {
      this.$router.push({ name: "home" });
    },
  },
};
</script>

<template>
  <router-link to="/" class="container">
    <img src="img/icons/logo.svg" alt="Logo" class="logo" />
  </router-link>
</template>

<style scoped>
.container {
  position: fixed;
  top: 0;
  left: 0;
  width: 40px;
  height: 100vh;
  background-color: rgba(98, 123, 122, 1);
}

.logo {
  width: 24px;
  height: 24px;
  margin: 9px auto 0;
}
</style>
