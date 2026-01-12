<template>
  <div class="p-4 space-y-4">
    <!-- Product Name -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Product Name
      </label>
      <input
        :value="product.name"
        @input="$emit('update', { field: 'name', value: $event.target.value })"
        type="text"
        placeholder="e.g., Fresh Meat"
        class="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded text-sm text-gray-100 placeholder-gray-500 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
      />
    </div>

    <!-- Price -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Price
      </label>
      <div class="flex items-center gap-2">
        <span class="text-gray-400">$</span>
        <input
          :value="product.price"
          @input="$emit('update', { field: 'price', value: $event.target.value })"
          type="text"
          placeholder="4.99"
          class="flex-1 px-3 py-2 bg-gray-700 border border-gray-600 rounded text-sm text-gray-100 placeholder-gray-500 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
        />
      </div>
    </div>

    <!-- Product Title Color -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Title Color
      </label>
      <div class="flex gap-2">
        <input
          :value="product.titleColor || '#374151'"
          @input="$emit('update', { field: 'titleColor', value: $event.target.value })"
          type="color"
          class="h-10 w-16 rounded cursor-pointer bg-gray-700 border border-gray-600"
        />
        <input
          :value="product.titleColor || '#374151'"
          @input="$emit('update', { field: 'titleColor', value: $event.target.value })"
          type="text"
          class="flex-1 px-3 py-2 bg-gray-700 border border-gray-600 rounded text-sm text-gray-100 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          placeholder="#374151"
        />
      </div>
    </div>

    <!-- Product Image -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Product Image
      </label>
      <label class="flex flex-col items-center justify-center w-full h-24 border-2 border-dashed border-gray-600 rounded cursor-pointer bg-gray-700 hover:bg-gray-650 transition-colors">
        <div v-if="!product.image" class="flex flex-col items-center justify-center">
          <svg class="w-6 h-6 mb-1 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
          </svg>
          <p class="text-xs text-gray-400">Upload image</p>
        </div>
        <div v-else class="relative w-full h-full flex items-center justify-center p-2">
          <img :src="product.image" alt="Product" class="max-h-20 max-w-full object-contain" />
        </div>
        <input
          type="file"
          class="hidden"
          accept="image/*"
          @change="handleImageUpload"
        />
      </label>
      <button
        v-if="product.image"
        @click="$emit('update', { field: 'image', value: null })"
        class="mt-2 text-xs text-red-400 hover:text-red-300 transition-colors"
      >
        Remove image
      </button>
    </div>

    <div class="border-t border-gray-700 pt-4">
      <h4 class="text-xs font-semibold text-gray-300 mb-3 uppercase tracking-wide">Badge Settings</h4>

      <!-- Badge Color -->
      <div class="mb-3">
        <label class="block text-xs font-medium text-gray-400 mb-2">
          Badge Color
        </label>
        <input
          :value="product.badge.color"
          @input="updateBadge('color', $event.target.value)"
          type="color"
          class="w-full h-10 rounded cursor-pointer bg-gray-700 border border-gray-600"
        />
      </div>

      <!-- Price Color -->
      <div class="mb-3">
        <label class="block text-xs font-medium text-gray-400 mb-2">
          Price Color
        </label>
        <input
          :value="product.badge.priceColor"
          @input="updateBadge('priceColor', $event.target.value)"
          type="color"
          class="w-full h-10 rounded cursor-pointer bg-gray-700 border border-gray-600"
        />
      </div>

      <!-- Points -->
      <div class="mb-3">
        <label class="block text-xs font-medium text-gray-400 mb-2">
          Points: {{ product.badge.points }}
        </label>
        <input
          :value="product.badge.points"
          @input="updateBadge('points', parseInt($event.target.value))"
          type="range"
          min="8"
          max="32"
          step="2"
          class="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-blue-500"
        />
      </div>

      <!-- Rotation -->
      <div class="mb-3">
        <label class="block text-xs font-medium text-gray-400 mb-2">
          Rotation: {{ product.badge.rotation }}°
        </label>
        <input
          :value="product.badge.rotation"
          @input="updateBadge('rotation', parseInt($event.target.value))"
          type="range"
          min="-180"
          max="180"
          step="5"
          class="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-blue-500"
        />
      </div>

      <!-- Show Extra Text -->
      <div class="mb-3">
        <label class="flex items-center cursor-pointer">
          <input
            :checked="product.badge.showExtraText"
            @change="updateBadge('showExtraText', $event.target.checked)"
            type="checkbox"
            class="w-4 h-4 text-blue-600 border-gray-600 rounded bg-gray-700 focus:ring-2 focus:ring-blue-500"
          />
          <span class="ml-2 text-xs font-medium text-gray-400">
            Show Extra Text
          </span>
        </label>
      </div>

      <!-- Extra Text Section -->
      <div v-if="product.badge.showExtraText" class="mb-3 p-3 bg-gray-900 rounded border border-gray-700">
        <!-- Badge Text Color -->
        <div class="mb-3">
          <label class="block text-xs font-medium text-gray-400 mb-2">
            Extra Text Color
          </label>
          <input
            :value="product.badge.textColor"
            @input="updateBadge('textColor', $event.target.value)"
            type="color"
            class="w-full h-10 rounded cursor-pointer bg-gray-700 border border-gray-600"
          />
        </div>

        <!-- Top Text -->
        <div class="mb-3">
          <label class="block text-xs font-medium text-gray-400 mb-2">
            Top Text
          </label>
          <input
            :value="product.badge.topText"
            @input="updateBadge('topText', $event.target.value)"
            type="text"
            placeholder="e.g., SALE"
            class="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded text-sm text-gray-100 placeholder-gray-500 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          />
        </div>

        <!-- Bottom Text -->
        <div class="mb-0">
          <label class="block text-xs font-medium text-gray-400 mb-2">
            Bottom Text
          </label>
          <input
            :value="product.badge.bottomText"
            @input="updateBadge('bottomText', $event.target.value)"
            type="text"
            placeholder="e.g., OFF"
            class="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded text-sm text-gray-100 placeholder-gray-500 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          />
        </div>
      </div>

      <!-- Badge Position -->
      <div class="mb-3">
        <label class="block text-xs font-medium text-gray-400 mb-2">
          Badge Position
        </label>
        <div class="grid grid-cols-2 gap-2">
          <button
            @click="updateBadge('position', 'top-left')"
            :class="[
              'py-2 px-2 rounded text-xs font-medium transition-colors',
              product.badge.position === 'top-left'
                ? 'bg-blue-600 text-white'
                : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
            ]"
          >
            Top Left
          </button>
          <button
            @click="updateBadge('position', 'top-right')"
            :class="[
              'py-2 px-2 rounded text-xs font-medium transition-colors',
              product.badge.position === 'top-right'
                ? 'bg-blue-600 text-white'
                : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
            ]"
          >
            Top Right
          </button>
          <button
            @click="updateBadge('position', 'bottom-left')"
            :class="[
              'py-2 px-2 rounded text-xs font-medium transition-colors',
              product.badge.position === 'bottom-left'
                ? 'bg-blue-600 text-white'
                : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
            ]"
          >
            Bottom Left
          </button>
          <button
            @click="updateBadge('position', 'bottom-right')"
            :class="[
              'py-2 px-2 rounded text-xs font-medium transition-colors',
              product.badge.position === 'bottom-right'
                ? 'bg-blue-600 text-white'
                : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
            ]"
          >
            Bottom Right
          </button>
        </div>
        <button
          @click="updateBadge('position', 'custom')"
          :class="[
            'w-full mt-2 py-2 px-2 rounded text-xs font-medium transition-colors',
            product.badge.position === 'custom'
              ? 'bg-blue-600 text-white'
              : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
          ]"
        >
          Custom Position
        </button>
      </div>

      <!-- Custom Position Controls -->
      <div v-if="product.badge.position === 'custom'" class="mb-0">
        <label class="block text-xs font-medium text-gray-400 mb-2">
          Adjust Position (X: {{ product.badge.customPosition?.x || 0 }}px, Y: {{ product.badge.customPosition?.y || 0 }}px)
        </label>
        <div class="grid grid-cols-3 gap-1.5">
          <div></div>
          <button
            @click="moveCustomBadge('up')"
            class="py-1.5 px-2 rounded text-xs font-medium bg-gray-700 text-gray-300 hover:bg-gray-600 transition-colors"
          >
            ↑
          </button>
          <div></div>
          <button
            @click="moveCustomBadge('left')"
            class="py-1.5 px-2 rounded text-xs font-medium bg-gray-700 text-gray-300 hover:bg-gray-600 transition-colors"
          >
            ←
          </button>
          <button
            @click="resetCustomPosition"
            class="py-1.5 px-2 rounded text-xs font-medium bg-gray-700 text-gray-300 hover:bg-red-600 transition-colors"
          >
            Reset
          </button>
          <button
            @click="moveCustomBadge('right')"
            class="py-1.5 px-2 rounded text-xs font-medium bg-gray-700 text-gray-300 hover:bg-gray-600 transition-colors"
          >
            →
          </button>
          <div></div>
          <button
            @click="moveCustomBadge('down')"
            class="py-1.5 px-2 rounded text-xs font-medium bg-gray-700 text-gray-300 hover:bg-gray-600 transition-colors"
          >
            ↓
          </button>
          <div></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  product: {
    type: Object,
    required: true
  }
})

const emit = defineEmits(['update'])

const handleImageUpload = (event) => {
  const file = event.target.files[0]
  if (file && file.type.startsWith('image/')) {
    const reader = new FileReader()
    reader.onload = (e) => {
      emit('update', { field: 'image', value: e.target.result })
    }
    reader.readAsDataURL(file)
  }
}

const updateBadge = (field, value) => {
  emit('update', {
    field: 'badge',
    value: {
      ...props.product.badge,
      [field]: value
    }
  })
}

const moveCustomBadge = (direction) => {
  const step = 10
  const currentPos = props.product.badge.customPosition || { x: 0, y: 0 }
  const newPosition = { ...currentPos }

  switch (direction) {
    case 'up':
      newPosition.y -= step
      break
    case 'down':
      newPosition.y += step
      break
    case 'left':
      newPosition.x -= step
      break
    case 'right':
      newPosition.x += step
      break
  }

  emit('update', {
    field: 'badge',
    value: {
      ...props.product.badge,
      customPosition: newPosition
    }
  })
}

const resetCustomPosition = () => {
  emit('update', {
    field: 'badge',
    value: {
      ...props.product.badge,
      customPosition: { x: 0, y: 0 }
    }
  })
}
</script>
