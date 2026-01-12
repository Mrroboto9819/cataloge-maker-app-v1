<template>
  <div class="h-full flex flex-col bg-gray-800 text-gray-100">
    <!-- Header -->
    <div class="px-4 py-3 border-b border-gray-700">
      <h3 class="text-sm font-semibold uppercase tracking-wider text-gray-300">
        Properties
      </h3>
      <p v-if="selected" class="text-xs text-gray-400 mt-1">
        {{ selectedLabel }}
      </p>
    </div>

    <!-- Properties Content -->
    <div class="flex-1 overflow-y-auto">
      <div v-if="!selected" class="flex items-center justify-center h-full text-gray-500 text-sm">
        <div class="text-center">
          <svg class="w-12 h-12 mx-auto mb-3 opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 15l-2 5L9 9l11 4-5 2zm0 0l5 5M7.188 2.239l.777 2.897M5.136 7.965l-2.898-.777M13.95 4.05l-2.122 2.122m-5.657 5.656l-2.12 2.122" />
          </svg>
          <p>Click an element to edit</p>
        </div>
      </div>

      <BackgroundProperties
        v-else-if="selected.type === 'background'"
        :catalog="catalog"
        @update="$emit('update', $event)"
      />

      <LogoProperties
        v-else-if="selected.type === 'logo'"
        :catalog="catalog"
        @update="$emit('update', $event)"
      />

      <TitleProperties
        v-else-if="selected.type === 'title'"
        :catalog="catalog"
        @update="$emit('update', $event)"
      />

      <SubtitleProperties
        v-else-if="selected.type === 'subtitle'"
        :catalog="catalog"
        @update="$emit('update', $event)"
      />

      <ProductPropertiesGrid
        v-else-if="selected.type === 'product' && catalog.mode === 'grid'"
        :product="selectedProduct"
        @update="handleProductUpdate"
      />

      <ProductPropertiesList
        v-else-if="selected.type === 'product' && catalog.mode === 'list'"
        :product="selectedProduct"
        @update="handleProductUpdate"
      />
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import BackgroundProperties from './properties/BackgroundProperties.vue'
import LogoProperties from './properties/LogoProperties.vue'
import TitleProperties from './properties/TitleProperties.vue'
import SubtitleProperties from './properties/SubtitleProperties.vue'
import ProductPropertiesGrid from './properties/ProductPropertiesGrid.vue'
import ProductPropertiesList from './properties/ProductPropertiesList.vue'

const props = defineProps({
  selected: {
    type: Object,
    default: null
  },
  catalog: {
    type: Object,
    required: true
  }
})

const emit = defineEmits(['update'])

const selectedLabel = computed(() => {
  if (!props.selected) return ''

  switch (props.selected.type) {
    case 'background':
      return 'Background & Display Mode'
    case 'logo':
      return 'Logo / Brand'
    case 'title':
      return 'Title'
    case 'subtitle':
      return 'Subtitle'
    case 'product':
      const product = props.catalog.products.find(p => p.id === props.selected.id)
      return product?.name || 'Product'
    default:
      return ''
  }
})

const selectedProduct = computed(() => {
  if (props.selected?.type !== 'product') return null
  return props.catalog.products.find(p => p.id === props.selected.id)
})

const handleProductUpdate = (update) => {
  emit('update', {
    type: 'product',
    id: props.selected.id,
    ...update
  })
}
</script>
