<template>
  <!-- Modal Overlay -->
  <div
    v-if="isOpen"
    class="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4"
    @click.self="$emit('close')"
  >
    <!-- Modal Content -->
    <div class="bg-white rounded-lg shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
      <!-- Header -->
      <div class="sticky top-0 bg-white border-b border-gray-200 px-6 py-4 flex justify-between items-center">
        <h2 class="text-xl font-semibold text-gray-800">
          {{ product.id ? 'Edit Product' : 'Add Product' }}
        </h2>
        <button
          @click="$emit('close')"
          class="text-gray-400 hover:text-gray-600 transition-colors"
        >
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>

      <!-- Form Content -->
      <div class="p-6">
        <!-- Product Name -->
        <div class="mb-4">
          <label class="block text-sm font-medium text-gray-700 mb-2">
            Product Name
          </label>
          <input
            v-model="localProduct.name"
            type="text"
            placeholder="e.g., Fresh Meat"
            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          />
        </div>

        <!-- Price -->
        <div class="mb-4">
          <label class="block text-sm font-medium text-gray-700 mb-2">
            Price
          </label>
          <input
            v-model="localProduct.price"
            type="text"
            placeholder="e.g., 4.99"
            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          />
        </div>

        <!-- List Mode Specific Fields -->
        <template v-if="mode === 'list'">
          <!-- Text Color -->
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Text Color
            </label>
            <input
              v-model="localProduct.textColor"
              type="color"
              class="w-full h-10 rounded border border-gray-300 cursor-pointer"
            />
          </div>

          <!-- Font Size -->
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Font Size: {{ localProduct.fontSize }}px
            </label>
            <input
              v-model.number="localProduct.fontSize"
              type="range"
              min="12"
              max="24"
              step="1"
              class="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-blue-600"
            />
          </div>
        </template>

        <!-- Grid Mode Specific Fields -->
        <template v-if="mode === 'grid'">
          <!-- Product Image Upload -->
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Product Image
            </label>
            <div class="flex items-center justify-center w-full">
              <label
                class="flex flex-col items-center justify-center w-full h-32 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100 transition-colors"
              >
                <div v-if="!localProduct.image" class="flex flex-col items-center justify-center pt-5 pb-6">
                  <svg
                    class="w-8 h-8 mb-2 text-gray-500"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
                    />
                  </svg>
                  <p class="text-sm text-gray-500">
                    <span class="font-semibold">Click to upload</span>
                  </p>
                </div>
                <div v-else class="relative w-full h-full flex items-center justify-center">
                  <img :src="localProduct.image" alt="Product" class="max-h-28 max-w-full object-contain" />
                </div>
                <input
                  type="file"
                  class="hidden"
                  accept="image/*"
                  @change="handleImageUpload"
                />
              </label>
            </div>
            <button
              v-if="localProduct.image"
              @click="localProduct.image = null"
              class="mt-2 text-xs text-red-600 hover:text-red-700"
            >
              Remove image
            </button>
          </div>

          <!-- Badge Customization -->
          <div class="mb-4 p-4 bg-gray-50 rounded-lg border border-gray-200">
            <h3 class="text-sm font-semibold text-gray-800 mb-3">Badge Customization</h3>

            <!-- Badge Color -->
            <div class="mb-3">
              <label class="block text-xs font-medium text-gray-600 mb-1">
                Badge Color
              </label>
              <input
                v-model="localProduct.badge.color"
                type="color"
                class="w-full h-10 rounded border border-gray-300 cursor-pointer"
              />
            </div>

            <!-- Price Color -->
            <div class="mb-3">
              <label class="block text-xs font-medium text-gray-600 mb-1">
                Price Color
              </label>
              <input
                v-model="localProduct.badge.priceColor"
                type="color"
                class="w-full h-10 rounded border border-gray-300 cursor-pointer"
              />
            </div>

            <!-- Number of Points -->
            <div class="mb-3">
              <label class="block text-xs font-medium text-gray-600 mb-1">
                Number of Points: {{ localProduct.badge.points }}
              </label>
              <input
                v-model.number="localProduct.badge.points"
                type="range"
                min="8"
                max="32"
                step="2"
                class="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-blue-600"
              />
            </div>

            <!-- Rotation Control -->
            <div class="mb-3">
              <label class="block text-xs font-medium text-gray-600 mb-1">
                Rotation: {{ localProduct.badge.rotation }}°
              </label>
              <input
                v-model.number="localProduct.badge.rotation"
                type="range"
                min="-180"
                max="180"
                step="5"
                class="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-blue-600"
              />
            </div>

            <!-- Show Extra Text Toggle -->
            <div class="mb-3">
              <label class="flex items-center cursor-pointer">
                <input
                  v-model="localProduct.badge.showExtraText"
                  type="checkbox"
                  class="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-2 focus:ring-blue-500"
                />
                <span class="ml-2 text-xs font-medium text-gray-600">
                  Show Extra Text (Top/Bottom)
                </span>
              </label>
            </div>

            <!-- Extra Text Section -->
            <div v-if="localProduct.badge.showExtraText" class="mb-3 p-3 bg-white rounded border border-gray-200">
              <!-- Badge Text Color -->
              <div class="mb-3">
                <label class="block text-xs font-medium text-gray-600 mb-1">
                  Extra Text Color
                </label>
                <input
                  v-model="localProduct.badge.textColor"
                  type="color"
                  class="w-full h-10 rounded border border-gray-300 cursor-pointer"
                />
              </div>

              <!-- Top Text -->
              <div class="mb-3">
                <label class="block text-xs font-medium text-gray-600 mb-1">
                  Top Text
                </label>
                <input
                  v-model="localProduct.badge.topText"
                  type="text"
                  placeholder="e.g., SALE"
                  class="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                />
              </div>

              <!-- Bottom Text -->
              <div class="mb-0">
                <label class="block text-xs font-medium text-gray-600 mb-1">
                  Bottom Text
                </label>
                <input
                  v-model="localProduct.badge.bottomText"
                  type="text"
                  placeholder="e.g., OFF"
                  class="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                />
              </div>
            </div>

            <!-- Positioning Mode -->
            <div class="mb-3">
              <label class="block text-xs font-medium text-gray-600 mb-2">
                Badge Position Mode
              </label>
              <div class="flex gap-2">
                <button
                  @click="localProduct.badge.positionMode = 'relative'"
                  :class="[
                    'flex-1 py-2 px-3 rounded-lg border-2 transition-colors text-sm',
                    localProduct.badge.positionMode === 'relative'
                      ? 'border-blue-500 bg-blue-50 text-blue-700'
                      : 'border-gray-300 hover:border-gray-400'
                  ]"
                >
                  Relative
                </button>
                <button
                  @click="localProduct.badge.positionMode = 'absolute'"
                  :class="[
                    'flex-1 py-2 px-3 rounded-lg border-2 transition-colors text-sm',
                    localProduct.badge.positionMode === 'absolute'
                      ? 'border-blue-500 bg-blue-50 text-blue-700'
                      : 'border-gray-300 hover:border-gray-400'
                  ]"
                >
                  Absolute
                </button>
              </div>
            </div>

            <!-- Relative Position Controls -->
            <div v-if="localProduct.badge.positionMode === 'relative'" class="mb-0">
              <label class="block text-xs font-medium text-gray-600 mb-2">
                Horizontal Alignment
              </label>
              <div class="flex gap-2">
                <button
                  @click="localProduct.badge.align = 'start'"
                  :class="[
                    'flex-1 py-2 px-3 rounded-lg border-2 transition-colors text-sm',
                    localProduct.badge.align === 'start'
                      ? 'border-blue-500 bg-blue-50 text-blue-700'
                      : 'border-gray-300 hover:border-gray-400'
                  ]"
                >
                  Left
                </button>
                <button
                  @click="localProduct.badge.align = 'center'"
                  :class="[
                    'flex-1 py-2 px-3 rounded-lg border-2 transition-colors text-sm',
                    localProduct.badge.align === 'center'
                      ? 'border-blue-500 bg-blue-50 text-blue-700'
                      : 'border-gray-300 hover:border-gray-400'
                  ]"
                >
                  Center
                </button>
                <button
                  @click="localProduct.badge.align = 'end'"
                  :class="[
                    'flex-1 py-2 px-3 rounded-lg border-2 transition-colors text-sm',
                    localProduct.badge.align === 'end'
                      ? 'border-blue-500 bg-blue-50 text-blue-700'
                      : 'border-gray-300 hover:border-gray-400'
                  ]"
                >
                  Right
                </button>
              </div>
            </div>

            <!-- Absolute Position Controls -->
            <div v-if="localProduct.badge.positionMode === 'absolute'" class="mb-0">
              <label class="block text-xs font-medium text-gray-600 mb-2">
                Move Badge (X: {{ localProduct.badge.position.x }}px, Y: {{ localProduct.badge.position.y }}px)
              </label>
              <div class="grid grid-cols-3 gap-2">
                <div></div>
                <button
                  @click="moveBadge('up')"
                  class="py-2 px-3 rounded-lg border-2 border-gray-300 hover:border-blue-400 hover:bg-blue-50 transition-colors text-sm font-medium"
                >
                  ↑ Up
                </button>
                <div></div>
                <button
                  @click="moveBadge('left')"
                  class="py-2 px-3 rounded-lg border-2 border-gray-300 hover:border-blue-400 hover:bg-blue-50 transition-colors text-sm font-medium"
                >
                  ← Left
                </button>
                <button
                  @click="localProduct.badge.position.x = 0; localProduct.badge.position.y = 0"
                  class="py-2 px-3 rounded-lg border-2 border-gray-300 hover:border-red-400 hover:bg-red-50 transition-colors text-sm font-medium"
                >
                  Reset
                </button>
                <button
                  @click="moveBadge('right')"
                  class="py-2 px-3 rounded-lg border-2 border-gray-300 hover:border-blue-400 hover:bg-blue-50 transition-colors text-sm font-medium"
                >
                  Right →
                </button>
                <div></div>
                <button
                  @click="moveBadge('down')"
                  class="py-2 px-3 rounded-lg border-2 border-gray-300 hover:border-blue-400 hover:bg-blue-50 transition-colors text-sm font-medium"
                >
                  ↓ Down
                </button>
                <div></div>
              </div>
            </div>
          </div>
        </template>
      </div>

      <!-- Footer Buttons -->
      <div class="sticky bottom-0 bg-gray-50 border-t border-gray-200 px-6 py-4 flex justify-end gap-3">
        <button
          @click="$emit('close')"
          class="px-4 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors font-medium"
        >
          Cancel
        </button>
        <button
          @click="handleSave"
          class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg transition-colors font-medium"
        >
          Save Product
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

const props = defineProps({
  isOpen: {
    type: Boolean,
    default: false
  },
  product: {
    type: Object,
    required: true
  },
  mode: {
    type: String,
    required: true,
    validator: (value) => ['list', 'grid'].includes(value)
  }
})

const emit = defineEmits(['close', 'save'])

const localProduct = ref({ ...props.product })

// Watch for product changes
watch(
  () => props.product,
  (newProduct) => {
    localProduct.value = { ...newProduct }
  },
  { deep: true }
)

const handleImageUpload = (event) => {
  const file = event.target.files[0]
  if (file && file.type.startsWith('image/')) {
    const reader = new FileReader()
    reader.onload = (e) => {
      localProduct.value.image = e.target.result
    }
    reader.readAsDataURL(file)
  }
}

const moveBadge = (direction) => {
  const step = 10
  switch (direction) {
    case 'up':
      localProduct.value.badge.position.y -= step
      break
    case 'down':
      localProduct.value.badge.position.y += step
      break
    case 'left':
      localProduct.value.badge.position.x -= step
      break
    case 'right':
      localProduct.value.badge.position.x += step
      break
  }
}

const handleSave = () => {
  emit('save', { ...localProduct.value })
  emit('close')
}
</script>
