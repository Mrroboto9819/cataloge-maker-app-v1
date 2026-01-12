<template>
  <div class="p-4 space-y-4">
    <!-- Display Mode -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Display Mode
      </label>
      <div class="grid grid-cols-2 gap-2">
        <button
          @click="$emit('update', { field: 'mode', value: 'grid' })"
          :class="[
            'py-2 px-3 rounded text-sm font-medium transition-colors',
            catalog.mode === 'grid'
              ? 'bg-blue-600 text-white'
              : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
          ]"
        >
          Grid
        </button>
        <button
          @click="$emit('update', { field: 'mode', value: 'list' })"
          :class="[
            'py-2 px-3 rounded text-sm font-medium transition-colors',
            catalog.mode === 'list'
              ? 'bg-blue-600 text-white'
              : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
          ]"
        >
          List
        </button>
      </div>
    </div>

    <!-- Grid Columns (only show in grid mode) -->
    <div v-if="catalog.mode === 'grid'" class="border-t border-gray-700 pt-4">
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Grid Columns: {{ catalog.gridColumns || 2 }}
      </label>
      <input
        :value="catalog.gridColumns || 2"
        @input="$emit('update', { field: 'gridColumns', value: parseInt($event.target.value) })"
        type="range"
        min="1"
        max="4"
        step="1"
        class="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-blue-500"
      />
      <div class="flex justify-between text-xs text-gray-500 mt-1">
        <span>1</span>
        <span>2</span>
        <span>3</span>
        <span>4</span>
      </div>
    </div>

    <!-- Global Badge Settings (only show in grid mode) -->
    <div v-if="catalog.mode === 'grid'" class="border-t border-gray-700 pt-4">
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Global Badge Settings
      </label>

      <!-- Override Toggle -->
      <div class="flex items-center justify-between mb-3">
        <span class="text-sm text-gray-300">Override Individual Spikes</span>
        <button
          @click="$emit('update', { field: 'globalBadge.overridePoints', value: !catalog.globalBadge.overridePoints })"
          :class="[
            'relative inline-flex h-6 w-11 items-center rounded-full transition-colors',
            catalog.globalBadge.overridePoints ? 'bg-blue-600' : 'bg-gray-600'
          ]"
        >
          <span
            :class="[
              'inline-block h-4 w-4 transform rounded-full bg-white transition-transform',
              catalog.globalBadge.overridePoints ? 'translate-x-6' : 'translate-x-1'
            ]"
          />
        </button>
      </div>

      <!-- Global Spike Count Slider -->
      <div v-if="catalog.globalBadge.overridePoints">
        <label class="block text-xs font-medium text-gray-300 mb-2">
          Global Spikes: {{ catalog.globalBadge.globalPoints || 16 }}
        </label>
        <input
          :value="catalog.globalBadge.globalPoints || 16"
          @input="$emit('update', { field: 'globalBadge.globalPoints', value: parseInt($event.target.value) })"
          type="range"
          min="8"
          max="24"
          step="2"
          class="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-blue-500"
        />
        <div class="flex justify-between text-xs text-gray-500 mt-1">
          <span>8</span>
          <span>16</span>
          <span>24</span>
        </div>
      </div>
    </div>

    <div class="border-t border-gray-700 pt-4">
      <!-- Background Type -->
      <div>
        <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
          Background Type
        </label>
        <div class="grid grid-cols-2 gap-2">
          <button
            @click="backgroundType = 'color'"
            :class="[
              'py-2 px-3 rounded text-sm font-medium transition-colors',
              backgroundType === 'color'
                ? 'bg-blue-600 text-white'
                : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
            ]"
          >
            Color
          </button>
          <button
            @click="backgroundType = 'image'"
            :class="[
              'py-2 px-3 rounded text-sm font-medium transition-colors',
              backgroundType === 'image'
                ? 'bg-blue-600 text-white'
                : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
            ]"
          >
            Image
          </button>
        </div>
      </div>

      <!-- Background Color -->
      <div v-if="backgroundType === 'color'" class="mt-4">
        <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
          Background Color
        </label>
        <div class="flex gap-2">
          <input
            :value="catalog.backgroundColor"
            @input="$emit('update', { field: 'backgroundColor', value: $event.target.value })"
            type="color"
            class="h-10 w-full rounded cursor-pointer bg-gray-700 border border-gray-600"
          />
          <input
            :value="catalog.backgroundColor"
            @input="$emit('update', { field: 'backgroundColor', value: $event.target.value })"
            type="text"
            class="flex-1 px-3 py-2 bg-gray-700 border border-gray-600 rounded text-sm text-gray-100 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            placeholder="#FFFFFF"
          />
        </div>
      </div>

      <!-- Background Image -->
      <div v-else class="mt-4">
        <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
          Background Image
        </label>
        <label class="flex flex-col items-center justify-center w-full h-24 border-2 border-dashed border-gray-600 rounded cursor-pointer bg-gray-700 hover:bg-gray-650 transition-colors">
          <div v-if="!catalog.backgroundImage" class="flex flex-col items-center justify-center">
            <svg class="w-8 h-8 mb-1 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
            </svg>
            <p class="text-xs text-gray-400">Upload image</p>
          </div>
          <div v-else class="text-xs text-gray-300 text-center px-2">
            <svg class="w-8 h-8 mx-auto mb-1 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            Image loaded
          </div>
          <input
            type="file"
            class="hidden"
            accept="image/*"
            @change="handleImageUpload"
          />
        </label>
        <button
          v-if="catalog.backgroundImage"
          @click="$emit('update', { field: 'backgroundImage', value: null })"
          class="mt-2 text-xs text-red-400 hover:text-red-300 transition-colors"
        >
          Remove background image
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const props = defineProps({
  catalog: {
    type: Object,
    required: true
  }
})

const emit = defineEmits(['update'])

const backgroundType = ref(props.catalog.backgroundImage ? 'image' : 'color')

const handleImageUpload = (event) => {
  const file = event.target.files[0]
  if (file && file.type.startsWith('image/')) {
    const reader = new FileReader()
    reader.onload = (e) => {
      emit('update', { field: 'backgroundImage', value: e.target.result })
      backgroundType.value = 'image'
    }
    reader.readAsDataURL(file)
  }
}
</script>
