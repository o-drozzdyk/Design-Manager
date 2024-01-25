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
    <router-view class="page-content" />
  </div>
</template>

<style lang="scss">
.page {
  position: relative;

  &-content {
    margin-left: 40px;
    padding: 24px 32px 0;
    min-height: calc(100vh - 24px);
  }
}

#app {
  font-family: "Roboto", Arial, sans-serif;
  font-weight: 400;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: rgba(255, 255, 255, 1);
}
</style>
