<script lang="ts">
import { Design } from "@/types/Design";
import { defineComponent } from "vue";

export default defineComponent({
  name: "DesignItem",
  props: {
    design: {
      type: Object as () => Design,
      default: () => ({} as Design),
    },
  },
  methods: {
    editDesign() {
      this.$router.push({
        name: "edit",
        params: { number: this.design.number },
      });
    },
  },
});
</script>

<template>
  <article class="item" @dblclick="editDesign">
    <img :src="design.photos[0]" alt="Design photo" class="item-photo" />
    <div class="item-bottom-info">
      <span class="item-bottom-info-number">{{ design.number }}</span>
      <span class="item-bottom-info-title">{{ design.title }}</span>
    </div>
  </article>
</template>

<style lang="scss" scoped>
@import "@/assets/mixins.scss";

.item {
  display: flex;
  flex-direction: column;
  gap: 16px;
  width: fit-content;
  margin-top: 20px;
  cursor: pointer;

  &-photo {
    width: 300px;
    height: 400px;
    box-shadow: 0px 1px 7px 0px rgba(0, 0, 0, 0.05);

    @include onPhone {
      width: 240px;
      height: 320px;
    }
  }

  &-bottom-info {
    display: flex;
    gap: 8px;
    align-items: center;

    &-number {
      width: 33px;
      height: 16px;
      padding-inline: 5px;
      border-radius: 8px;
      font-size: 11px;
      line-height: 16px;
      color: rgba(0, 0, 0, 1);
      background-color: rgba(255, 255, 255, 1);
    }

    &-title {
      font-size: 16px;

      @include onPhone {
        font-size: 14px;
      }
    }
  }
}
</style>
