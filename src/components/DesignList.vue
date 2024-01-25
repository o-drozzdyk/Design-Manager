<script lang="ts">
import DesignItem from "@/components/DesignItem.vue";
import { Design } from "@/types/Design";
import { defineComponent } from "vue";

export default defineComponent({
  name: "DesignList",
  props: {
    designs: {
      type: Array as () => Design[],
      default: () => [] as Design[],
    },
  },
  components: {
    DesignItem,
  },
});
</script>

<template>
  <div class="list">
    <DesignItem v-for="item in designs" :key="item.number" :design="item" />
  </div>
</template>

<style scoped>
.list {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}
</style>
