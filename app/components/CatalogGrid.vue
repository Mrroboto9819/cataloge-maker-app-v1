<template>
  <div
    ref="catalogContainer"
    data-catalog-grid
    class="mx-auto shadow-2xl"
    :style="{
      width: '794px',
      minHeight: '1123px',
      backgroundImage: catalog.backgroundImage ? `url(${catalog.backgroundImage})` : 'none',
      backgroundColor: catalog.backgroundImage ? 'transparent' : catalog.backgroundColor,
      backgroundSize: catalog.backgroundImage ? '794px auto' : 'cover',
      backgroundRepeat: catalog.backgroundImage ? 'repeat-y' : 'no-repeat',
      backgroundPosition: 'top center',
      padding: '48px 32px'
    }"
  >
    <!-- Title Section -->
    <div class="mb-8">
      <h1
        v-if="catalog.title"
        class="font-bold text-center mb-2"
        :style="{
          color: catalog.titleColor,
          fontSize: catalog.titleSize || '36px'
        }"
      >
        {{ catalog.title }}
      </h1>
      <h2
        v-if="catalog.subtitle"
        class="font-medium text-center"
        :style="{
          color: catalog.subtitleColor,
          fontSize: catalog.subtitleSize || '20px'
        }"
      >
        {{ catalog.subtitle }}
      </h2>
    </div>

    <!-- Products Grid (Grid Mode) -->
    <div
      v-if="catalog.mode === 'grid'"
      class="grid gap-6"
      :style="{
        gridTemplateColumns: 'repeat(2, 1fr)',
        gridAutoRows: 'auto'
      }"
    >
      <ProductCard
        v-for="product in catalog.products"
        :key="product.id"
        :product="product"
        @edit="$emit('edit-product', product)"
      />
    </div>

    <!-- Products List (List Mode) -->
    <div
      v-else
      class="flex flex-col gap-2"
    >
      <ProductListItem
        v-for="product in catalog.products"
        :key="product.id"
        :product="product"
        @edit="$emit('edit-product', product)"
      />
    </div>

    <!-- Empty State -->
    <div
      v-if="catalog.products.length === 0"
      class="flex flex-col items-center justify-center py-20 text-gray-400"
    >
      <svg class="w-20 h-20 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"
        />
      </svg>
      <p class="text-lg font-medium">No products yet</p>
      <p class="text-sm">Click "Add Product" to get started</p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import ProductCard from './ProductCard.vue'
import ProductListItem from './ProductListItem.vue'

defineProps({
  catalog: {
    type: Object,
    required: true
  }
})

defineEmits(['edit-product'])

const catalogContainer = ref(null)

// Expose the ref for parent component to access (for export)
defineExpose({
  catalogContainer
})
</script>
