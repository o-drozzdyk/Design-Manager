<script lang="ts">
import LeftPanel from "@/components/LeftPanel.vue";

export default {
  components: {
    LeftPanel,
  },
};
</script>

<template>
  <div class="page">
    <LeftPanel />
    <router-view class="main-content" />
  </div>
</template>

<style lang="scss">
.page {
  position: relative;
  // width: 100%;
}

.main-content {
  margin-left: 40px;
  padding: 24px 32px 0;
  min-height: calc(100vh - 24px);
  // width: fit-content;
}

#app {
  font-family: "Roboto", Arial, sans-serif;
  font-weight: 400;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

nav {
  // padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
</style>
