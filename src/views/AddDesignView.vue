<script lang="ts">
import GoBackButton from "@/components/GoBackButton.vue";
import CustomButton from "@/components/CustomButton.vue";
import { Design } from "@/types/Design";
import { defineComponent } from "vue";

export default defineComponent({
  name: "AddPage",
  components: {
    GoBackButton,
    CustomButton,
  },
  props: {
    number: {
      type: String,
    },
  },
  data() {
    let designs = [];
    const jsonDesigns = localStorage.getItem("designs") || "[]";

    try {
      designs = JSON.parse(jsonDesigns);
      // eslint-disable-next-line no-empty
    } catch (e) {}

    let currentDesign = designs.find(
      (design: Design) => design.number === this.number
    );

    return {
      currentDesign,
      designs,
      selectedPhotos: currentDesign?.photos || [],
      newNumber: currentDesign?.number || "",
      title: currentDesign?.title || "",
      link: currentDesign?.link || "",
      isPublished: currentDesign?.isPublished || false,
      isErrorMessageShown: false,
      currentPhotoIndex: -1,
    };
  },
  methods: {
    onFileSelected(event: Event) {
      const input = event.target as HTMLInputElement;
      const files = input.files;
      if (files && files.length > 0) {
        const selectedFile = files[0];
        this.savePhoto(selectedFile);
      }
      input.value = "";
    },
    savePhoto(file: File) {
      const reader = new FileReader();
      reader.onload = () => {
        this.selectedPhotos.push(reader.result);
      };
      reader.readAsDataURL(file);
      console.log(this.selectedPhotos);
    },
    addDesign() {
      if (
        this.newNumber.length > 0 &&
        this.title.length > 0 &&
        this.link.length > 0 &&
        this.selectedPhotos.length > 0
      ) {
        if (this.currentDesign) {
          const editingDesign = this.designs.find(
            (design: Design) => design.number === this.currentDesign.number
          );

          editingDesign.number = this.newNumber;
          editingDesign.title = this.title;
          editingDesign.link = this.link;
          editingDesign.photos = this.selectedPhotos;
          editingDesign.isPublished = this.isPublished;
        } else {
          this.designs.push({
            photos: this.selectedPhotos,
            number: this.newNumber,
            title: this.title,
            link: this.link,
            isPublished: true,
          });
        }

        localStorage.setItem("designs", JSON.stringify(this.designs));
        this.isErrorMessageShown = false;
        this.$router.push("/");
      } else {
        this.showErrorMessage();
      }
    },
    removeDesign() {
      const designsLeft = this.designs.filter(
        (design: Design) => design.number !== this.currentDesign.number
      );

      localStorage.setItem("designs", JSON.stringify(designsLeft));
      this.isErrorMessageShown = false;
      this.$router.push("/");
    },
    showDeleteIcon(index: number) {
      this.currentPhotoIndex = index;
    },
    hideDeleteIcon(index: number) {
      if (this.currentPhotoIndex === index) {
        setTimeout(() => {
          this.currentPhotoIndex = -1;
        }, 1000);
      }
    },
    removePhoto(src: string) {
      this.selectedPhotos = this.selectedPhotos.filter(
        (photo: string) => photo !== src
      );
    },
    togglePublished() {
      this.isPublished = !this.isPublished;
    },
    showErrorMessage() {
      this.isErrorMessageShown = true;

      setTimeout(this.closeErrorMessage, 5000);
    },
    closeErrorMessage() {
      this.isErrorMessageShown = false;
    },
  },
});
</script>

<template>
  <div class="page">
    <div class="page-container">
      <GoBackButton />

      <div class="form-container">
        <div class="toggle">
          <div
            class="toggle-button"
            :class="{ 'toggle-button-active': isPublished }"
            @click="togglePublished"
          >
            <div class="toggle-button-circle"></div>
          </div>

          <span
            class="toggle-text"
            :class="{ 'toggle-text-active': isPublished }"
          >
            {{ isPublished ? "Опублікований" : "Неопублікований" }}
          </span>
        </div>

        <div class="photos-container" v-if="selectedPhotos.length > 0">
          <div
            class="photos-container-wrapper"
            v-for="(photoUrl, index) in selectedPhotos"
            :key="photoUrl"
            @mouseover="showDeleteIcon(index)"
            @mouseout="hideDeleteIcon(index)"
          >
            <img
              :src="photoUrl"
              alt="Selected image"
              class="photos-container-wrapper-selected-photo"
            />

            <img
              src="img/icons/delete.svg"
              alt="Delete"
              class="photos-container-wrapper-delete"
              @click="removePhoto(photoUrl)"
              v-if="currentPhotoIndex === index"
            />
          </div>

          <label for="fileInput" class="photos-container-wrapper--small">
            <img
              src="img/icons/union.svg"
              alt="Empty image"
              class="photos-container-wrapper--small-plus"
            />
          </label>
          <input
            id="fileInput"
            type="file"
            accept=".jpg, .png, .svg"
            @change="onFileSelected"
            class="input-hidden"
          />
        </div>

        <label for="fileInput" class="photo-container" v-else>
          <img
            src="img/icons/image.svg"
            alt="Empty image"
            class="photo-container-photo-icon"
          />
        </label>
        <input
          id="fileInput"
          type="file"
          accept=".jpg, .png, .svg"
          @change="onFileSelected"
          class="input-hidden"
        />

        <div class="form-container-info">
          <input
            type="text"
            placeholder="###"
            class="input input-number"
            v-model="newNumber"
          />
          <input
            type="text"
            placeholder="Назва дизайну"
            class="input input-title"
            v-model="title"
          />
        </div>

        <input
          type="text"
          placeholder="https://design###.horoshop.ua/"
          class="input input-url"
          v-model="link"
        />

        <transition name="fade">
          <div v-if="isErrorMessageShown" class="form-container-error-message">
            <div class="form-container-error-message-top">
              <img
                src="img/icons/close.svg"
                alt="Close"
                class="form-container-error-message-top-icon-close"
                @click="closeErrorMessage"
              />
            </div>

            <p class="form-container-error-message-text">
              Заповніть всі поля форми
            </p>
          </div>
        </transition>
      </div>
    </div>

    <div class="page-buttons">
      <CustomButton
        v-if="currentDesign"
        text="Видалити"
        :specialStyles="true"
        @click.prevent="removeDesign"
      />
      <CustomButton text="Зберегти і вийти" @click.prevent="addDesign" />
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import "@/assets/mixins.scss";

.page {
  display: flex;
  justify-content: space-between;

  @include onPhone {
    flex-direction: column;
    justify-content: initial;
    width: max-content;
  }

  &-container {
    display: flex;
    gap: 96px;
    padding-bottom: 24px;

    @include onTablet {
      gap: 32px;
    }

    @include onPhone {
      flex-direction: column;
      gap: 40px;
    }
  }

  &-buttons {
    display: flex;
    gap: 8px;

    @include onPhone {
      align-self: flex-end;
    }
  }
}

.form-container {
  display: flex;
  flex-direction: column;
  gap: 24px;
  width: 600px;

  @include onTablet {
    width: 340px;
  }

  @include onPhone {
    width: 240px;
    gap: 16px;
  }

  &-info {
    display: flex;
    gap: 8px;
  }

  &-error-message {
    width: auto;
    border-radius: 3px;
    border-color: rgba(0, 0, 0, 0.2);
    box-shadow: 0px 8px 20px 0px rgba(0, 0, 0, 0.15);
    background-color: rgba(255, 255, 255, 1);

    &-top {
      display: flex;
      justify-content: flex-end;
      border-top-left-radius: 3px;
      border-top-right-radius: 3px;
      background-color: rgba(0, 0, 0, 0.1);

      &-icon-close {
        width: 24px;
        height: 24px;
        cursor: pointer;
      }
    }

    &-text {
      padding: 24px;
      color: rgba(230, 22, 16, 1);
      font-size: 18px;

      @include onPhone {
        font-size: 16px;
      }
    }
  }
}

.toggle {
  display: flex;
  align-items: center;
  gap: 10px;

  &-button {
    display: flex;
    align-items: center;
    width: 64px;
    height: 24px;
    border-radius: 14px;
    background-color: rgba(0, 0, 0, 0.1);
    cursor: pointer;
    transition: background-color 0.3s ease-in-out;

    &-active {
      justify-content: flex-end;
      gap: 10px;
      background-color: rgba(122, 177, 14, 1);
    }

    &-circle {
      margin-inline: 2px;
      width: 20px;
      height: 20px;
      border-radius: 14px;
      background-color: rgba(255, 255, 255, 1);
      box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.15);
    }
  }

  &-text {
    color: rgba(34, 34, 34, 1);
    font-size: 14px;

    @include onTablet {
      font-size: 12px;
    }

    &-active {
      color: rgba(105, 151, 7, 1);
    }
  }
}

.photos-container {
  display: flex;
  width: auto;
  gap: 8px;
  flex-wrap: wrap;
  align-items: flex-start;

  @include onPhone {
    justify-content: space-between;
  }

  &-wrapper {
    position: relative;
    width: fit-content;
    height: fit-content;

    &-selected-photo {
      box-sizing: border-box;
      width: 120px;
      height: auto;
      border: 1px solid rgba(0, 0, 0, 0.1);
      border-radius: 3px;
      opacity: 1;
      transition: opacity 0.3s ease;

      &:hover {
        border-color: rgba(0, 0, 0, 0.2);
        box-shadow: 0px 8px 20px 0px rgba(0, 0, 0, 0.15);
        background-color: rgba(255, 255, 255, 1);
        opacity: 0.7;
        cursor: grab;
      }
    }

    &-delete {
      position: absolute;
      bottom: 6px;
      right: 4px;
      width: 16px;
      height: 16px;
      padding: 4px;
      border-radius: 3px;
      background-color: rgba(0, 0, 0, 0.5);
    }

    &--small {
      box-sizing: border-box;
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 16px;
      width: 120px;
      height: 120px;
      border: 2px dashed rgba(0, 0, 0, 0.1);
      border-radius: 3px;
      color: rgba(0, 0, 0, 1);
      background-color: rgba(255, 255, 255, 1);
      cursor: pointer;

      &-plus {
        width: 30px;
        height: 30px;
      }
    }
  }
}

.photo-container {
  box-sizing: border-box;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 16px;
  height: 120px;
  border: 2px dashed rgba(0, 0, 0, 0.1);
  border-radius: 3px;
  color: rgba(0, 0, 0, 1);
  background-color: rgba(255, 255, 255, 1);
  cursor: pointer;

  &-photo-icon {
    margin: 0;
    width: 60px;
    height: 48px;
  }
}

.input {
  box-sizing: border-box;
  padding-left: 8px;
  border: 1px solid rgba(0, 0, 0, 0.2);
  border-radius: 3px;
  font-size: 14px;

  @include onTablet {
    font-size: 12px;
  }

  &-hidden {
    display: none;
  }

  &-number {
    width: 80px;
    height: 32px;

    @include onPhone {
      width: 60px;
    }
  }

  &-title {
    width: 100%;
  }

  &-url {
    width: auto;
    height: 32px;
  }
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}

.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
