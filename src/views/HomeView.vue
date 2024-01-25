<script lang="ts">
import CustomButton from "@/components/CustomButton.vue";
import DesignList from "@/components/DesignList.vue";
import { defineComponent } from "vue";
import { Router } from "vue-router";

export default defineComponent({
  components: {
    CustomButton,
    DesignList,
  },
  data() {
    let designs = [];
    const jsonDesigns = localStorage.getItem("designs") || "[]";

    try {
      designs = JSON.parse(jsonDesigns);
      // eslint-disable-next-line no-empty
    } catch (e) {}

    return {
      designs,
    };
  },
  methods: {
    handleButtonClick(this: { $router: Router }) {
      this.$router.push("add");
    },
  },
});
</script>

<template>
  <div class="home">
    <div class="home-top-bar">
      <h2 class="home-top-bar-title">Всі дизайни</h2>
      <CustomButton text="Додати дизайн" @click.prevent="handleButtonClick" />
    </div>

    <DesignList :designs="designs" />
  </div>
</template>

<style lang="scss">
@import "@/assets/mixins.scss";

.home {
  background-color: rgba(44, 61, 57, 1);
  padding-bottom: 24px;

  @include onPhone {
    min-width: max-content;
  }

  &-top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;

    &-title {
      font-size: 24px;
      color: rgba(255, 255, 255, 1);

      @include onTablet {
        font-size: 20px;
      }

      @include onPhone {
        font-size: 18px;
      }
    }
  }
}
</style>
