<template>
  <div
    ref="catalogContainer"
    data-catalog-canvas
    class="mx-auto shadow-2xl relative overflow-hidden editable-element"
    :class="{ 'selected': selected?.type === 'background' }"
    :style="{
      width: '794px',
      minHeight: '1123px',
      backgroundImage: catalog.backgroundImage ? `url(${catalog.backgroundImage})` : 'none',
      backgroundColor: catalog.backgroundImage ? 'transparent' : catalog.backgroundColor,
      backgroundSize: 'cover',
      backgroundRepeat: 'no-repeat',
      backgroundPosition: 'center center',
      cursor: 'pointer'
    }"
    @click.self="$emit('select', { type: 'background' })"
  >
    <!-- Dark Overlay (between background and content) -->
    <div
      class="absolute inset-0 pointer-events-auto"
      style="background-color: rgba(0, 0, 0, 0.3);"
      @click="$emit('select', { type: 'background' })"
    ></div>

    <!-- Content Container -->
    <div class="relative z-10" style="padding: 48px 32px; pointer-events: none;">
      <div style="pointer-events: auto;">
      <!-- Logo Section -->
      <div
        v-if="catalog.logo.image"
        @click.stop="$emit('select', { type: 'logo' })"
        class="editable-element"
        :class="{ 'selected': selected?.type === 'logo' }"
        :style="{
          display: 'flex',
          justifyContent: catalog.logo.alignment === 'left' ? 'flex-start' : catalog.logo.alignment === 'right' ? 'flex-end' : 'center',
          marginBottom: catalog.logo.marginBottom + 'px',
          cursor: 'pointer',
          borderRadius: '4px',
          padding: '4px'
        }"
      >
        <img
          :src="catalog.logo.image"
          alt="Logo"
          :style="{
            width: catalog.logo.width + 'px',
            height: catalog.logo.height + 'px',
            objectFit: 'contain',
            display: 'block',
            pointerEvents: 'none'
          }"
        />
      </div>

      <!-- Title Section -->
      <div class="mb-8">
        <h1
          v-if="catalog.title"
          @click.stop="$emit('select', { type: 'title' })"
          class="editable-element"
          :class="{ 'selected': selected?.type === 'title' }"
          :style="{
            color: catalog.titleColor,
            fontSize: catalog.titleSize + 'px',
            fontWeight: '700',
            textAlign: 'center',
            marginBottom: '8px',
            cursor: 'pointer',
            borderRadius: '4px',
            padding: '4px 8px'
          }"
        >
          {{ catalog.title }}
        </h1>
        <h2
          v-if="catalog.subtitle"
          @click.stop="$emit('select', { type: 'subtitle' })"
          class="editable-element"
          :class="{ 'selected': selected?.type === 'subtitle' }"
          :style="{
            color: catalog.subtitleColor,
            fontSize: catalog.subtitleSize + 'px',
            fontWeight: '500',
            textAlign: 'center',
            cursor: 'pointer',
            borderRadius: '4px',
            padding: '4px 8px'
          }"
        >
          {{ catalog.subtitle }}
        </h2>
      </div>

      <!-- Products Grid (Grid Mode) -->
      <div
        v-if="catalog.mode === 'grid'"
        :style="{
          display: 'grid',
          gridTemplateColumns: `repeat(${catalog.gridColumns || 2}, 1fr)`,
          gridAutoRows: 'auto',
          gap: '24px'
        }"
      >
        <div
          v-for="product in catalog.products"
          :key="product.id"
          :data-product-id="product.id"
          @click.stop="$emit('select', { type: 'product', id: product.id })"
          class="editable-element"
          :class="{ 'selected': selected?.type === 'product' && selected?.id === product.id }"
          :style="{
            borderRadius: '8px',
            cursor: 'pointer'
          }"
        >
          <ProductCard :product="product" :catalog="catalog" @edit.stop />
        </div>
      </div>

      <!-- Products List (List Mode) -->
      <div
        v-else
        :style="{
          display: 'flex',
          flexDirection: 'column',
          gap: '8px'
        }"
      >
        <div
          v-for="product in catalog.products"
          :key="product.id"
          :data-product-id="product.id"
          @click.stop="$emit('select', { type: 'product', id: product.id })"
          class="editable-element"
          :class="{ 'selected': selected?.type === 'product' && selected?.id === product.id }"
          :style="{
            borderRadius: '4px',
            cursor: 'pointer'
          }"
        >
          <ProductListItem :product="product" @edit.stop />
        </div>
      </div>

      <!-- Empty State -->
      <div
        v-if="catalog.products.length === 0"
        :style="{
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          justifyContent: 'center',
          paddingTop: '80px',
          paddingBottom: '80px',
          color: '#9ca3af'
        }"
      >
        <svg :style="{ width: '80px', height: '80px', marginBottom: '16px' }" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"
          />
        </svg>
        <p :style="{ fontSize: '18px', fontWeight: '500' }">No products yet</p>
        <p :style="{ fontSize: '14px' }">Click "Add Product" to get started</p>
      </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import ProductCard from '../ProductCard.vue'
import ProductListItem from '../ProductListItem.vue'

defineProps({
  catalog: {
    type: Object,
    required: true
  },
  selected: {
    type: Object,
    default: null
  }
})

defineEmits(['select'])

const catalogContainer = ref(null)

// Expose the ref for parent component to access (for export)
defineExpose({
  catalogContainer
})
</script>

<style scoped>
.editable-element {
  outline: 2px dotted transparent;
  outline-offset: 4px;
  transition: outline-color 0.15s ease, outline-width 0.15s ease;
}

.editable-element:hover {
  outline-color: rgba(255, 255, 255, 0.5);
  outline-width: 2px;
}

.editable-element:active {
  outline-color: rgba(255, 255, 255, 0.7);
  outline-width: 3px;
}

.editable-element.selected {
  outline-color: rgba(255, 255, 255, 1);
  outline-width: 3px;
}
</style>
