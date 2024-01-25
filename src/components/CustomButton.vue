<script lang="ts">
import { defineComponent } from "vue";

export default defineComponent({
  name: "CustomButton",
  props: {
    text: {
      type: String,
      required: true,
    },
    specialStyles: {
      type: Boolean,
      default: false,
    },
  },
});
</script>

<template>
  <button class="custom-button" :class="{ 'special-style': specialStyles }">
    {{ text }}
  </button>
</template>

<style scoped>
.custom-button {
  box-sizing: border-box;
  padding-inline: 11px;
  height: 32px;
  border: 1px solid rgba(0, 0, 0, 0.2);
  border-radius: 3px;
  text-decoration: none;

  font-family: "Roboto", sans-serif;
  font-size: 14px;
  background: #418af2;
  color: rgba(255, 255, 255, 1);
  cursor: pointer;
  transition: background-color ease-in-out 0.3s;
}

.custom-button:hover {
  background-color: rgba(44, 112, 209, 1);
}

.special-style {
  border: 1px solid rgba(0, 0, 0, 0.2);
  background-color: white;
  color: rgba(230, 22, 16, 1);
}

.special-style:hover {
  border: 1px solid rgba(0, 0, 0, 0.35);
  background-color: white;
  transition: border-color ease-in-out 0.3s;
}
</style>
