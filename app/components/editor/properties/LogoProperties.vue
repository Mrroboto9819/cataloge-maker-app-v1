<template>
  <div class="p-4 space-y-4">
    <!-- Logo Image Upload -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Logo Image
      </label>
      <label class="flex flex-col items-center justify-center w-full h-32 border-2 border-dashed border-gray-600 rounded cursor-pointer bg-gray-700 hover:bg-gray-650 transition-colors">
        <div v-if="!catalog.logo.image" class="flex flex-col items-center justify-center">
          <svg class="w-8 h-8 mb-2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
          </svg>
          <p class="text-xs text-gray-400">Upload logo (PNG recommended)</p>
        </div>
        <div v-else class="relative w-full h-full flex items-center justify-center p-3">
          <img :src="catalog.logo.image" alt="Logo" class="max-h-full max-w-full object-contain" />
        </div>
        <input
          type="file"
          class="hidden"
          accept="image/*"
          @change="handleLogoUpload"
        />
      </label>
      <button
        v-if="catalog.logo.image"
        @click="$emit('update', { field: 'logo', value: { ...catalog.logo, image: null } })"
        class="mt-2 text-xs text-red-400 hover:text-red-300 transition-colors"
      >
        Remove logo
      </button>
    </div>

    <!-- Width -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Width: {{ catalog.logo.width }}px
      </label>
      <input
        :value="catalog.logo.width"
        @input="updateLogo('width', parseInt($event.target.value))"
        type="range"
        min="50"
        max="600"
        step="10"
        class="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-blue-500"
      />
    </div>

    <!-- Height -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Height: {{ catalog.logo.height }}px
      </label>
      <input
        :value="catalog.logo.height"
        @input="updateLogo('height', parseInt($event.target.value))"
        type="range"
        min="30"
        max="400"
        step="10"
        class="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-blue-500"
      />
    </div>

    <!-- Alignment -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Alignment
      </label>
      <div class="grid grid-cols-3 gap-2">
        <button
          @click="updateLogo('alignment', 'left')"
          :class="[
            'py-2 px-2 rounded text-xs font-medium transition-colors',
            catalog.logo.alignment === 'left'
              ? 'bg-blue-600 text-white'
              : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
          ]"
        >
          Left
        </button>
        <button
          @click="updateLogo('alignment', 'center')"
          :class="[
            'py-2 px-2 rounded text-xs font-medium transition-colors',
            catalog.logo.alignment === 'center'
              ? 'bg-blue-600 text-white'
              : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
          ]"
        >
          Center
        </button>
        <button
          @click="updateLogo('alignment', 'right')"
          :class="[
            'py-2 px-2 rounded text-xs font-medium transition-colors',
            catalog.logo.alignment === 'right'
              ? 'bg-blue-600 text-white'
              : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
          ]"
        >
          Right
        </button>
      </div>
    </div>

    <!-- Margin Bottom -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Spacing Below: {{ catalog.logo.marginBottom }}px
      </label>
      <input
        :value="catalog.logo.marginBottom"
        @input="updateLogo('marginBottom', parseInt($event.target.value))"
        type="range"
        min="0"
        max="100"
        step="4"
        class="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-blue-500"
      />
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  catalog: {
    type: Object,
    required: true
  }
})

const emit = defineEmits(['update'])

const handleLogoUpload = (event) => {
  const file = event.target.files[0]
  if (file && file.type.startsWith('image/')) {
    const reader = new FileReader()
    reader.onload = (e) => {
      emit('update', {
        field: 'logo',
        value: {
          ...props.catalog.logo,
          image: e.target.result
        }
      })
    }
    reader.readAsDataURL(file)
  }
}

const updateLogo = (field, value) => {
  emit('update', {
    field: 'logo',
    value: {
      ...props.catalog.logo,
      [field]: value
    }
  })
}
</script>
