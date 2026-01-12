<template>
  <div class="h-full flex flex-col text-gray-100">
    <!-- Layers List -->
    <div class="flex-1 overflow-y-auto">
      <!-- Background Layer -->
      <div
        @click="$emit('select', { type: 'background' })"
        :class="[
          'px-4 py-2.5 flex items-center gap-2 cursor-pointer transition-all',
          selected?.type === 'background'
            ? 'bg-blue-600 bg-opacity-20 text-blue-300 shadow-[inset_2px_0_0_rgb(59,130,246)]'
            : 'hover:bg-gray-700 shadow-[inset_2px_0_0_transparent]'
        ]"
      >
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
        </svg>
        <span class="text-sm font-medium">Background</span>
      </div>

      <!-- Logo Layer -->
      <div
        @click="$emit('select', { type: 'logo' })"
        :class="[
          'px-4 py-2.5 flex items-center gap-2 cursor-pointer transition-all',
          selected?.type === 'logo'
            ? 'bg-blue-600 bg-opacity-20 text-blue-300 shadow-[inset_2px_0_0_rgb(59,130,246)]'
            : 'hover:bg-gray-700 shadow-[inset_2px_0_0_transparent]'
        ]"
      >
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01" />
        </svg>
        <span class="text-sm font-medium">Logo</span>
      </div>

      <!-- Title Layer -->
      <div
        @click="$emit('select', { type: 'title' })"
        :class="[
          'px-4 py-2.5 flex items-center gap-2 cursor-pointer transition-all',
          selected?.type === 'title'
            ? 'bg-blue-600 bg-opacity-20 text-blue-300 shadow-[inset_2px_0_0_rgb(59,130,246)]'
            : 'hover:bg-gray-700 shadow-[inset_2px_0_0_transparent]'
        ]"
      >
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
        </svg>
        <span class="text-sm font-medium">Title</span>
      </div>

      <!-- Subtitle Layer -->
      <div
        @click="$emit('select', { type: 'subtitle' })"
        :class="[
          'px-4 py-2.5 flex items-center gap-2 cursor-pointer transition-all',
          selected?.type === 'subtitle'
            ? 'bg-blue-600 bg-opacity-20 text-blue-300 shadow-[inset_2px_0_0_rgb(59,130,246)]'
            : 'hover:bg-gray-700 shadow-[inset_2px_0_0_transparent]'
        ]"
      >
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
        </svg>
        <span class="text-sm font-medium">Subtitle</span>
      </div>

      <!-- Products Group -->
      <div>
        <!-- Products Header -->
        <div
          @click="productsExpanded = !productsExpanded"
          class="px-4 py-2.5 flex items-center gap-2 cursor-pointer hover:bg-gray-700 transition-colors"
        >
          <svg
            :class="['w-3 h-3 transition-transform', productsExpanded ? 'rotate-90' : '']"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
          </svg>
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
          </svg>
          <span class="text-sm font-medium">Products</span>
          <span class="text-xs text-gray-400 ml-auto">({{ catalog.products.length }})</span>
        </div>

        <!-- Products List -->
        <div v-if="productsExpanded" class="bg-gray-900 bg-opacity-30">
          <div
            v-for="product in catalog.products"
            :key="product.id"
            @click="$emit('select', { type: 'product', id: product.id })"
            :class="[
              'px-4 py-2 pl-10 flex items-center gap-2 cursor-pointer transition-all group',
              selected?.type === 'product' && selected?.id === product.id
                ? 'bg-blue-600 bg-opacity-20 text-blue-300 shadow-[inset_2px_0_0_rgb(59,130,246)]'
                : 'hover:bg-gray-700 shadow-[inset_2px_0_0_transparent]'
            ]"
          >
            <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
            </svg>
            <span class="text-sm flex-1 truncate">{{ product.name || 'Untitled Product' }}</span>
            <button
              @click.stop="$emit('delete-product', product.id)"
              class="opacity-0 group-hover:opacity-100 transition-opacity p-1 hover:bg-red-600 rounded"
              title="Delete product"
            >
              <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
              </svg>
            </button>
          </div>

          <!-- Empty State -->
          <div v-if="catalog.products.length === 0" class="px-4 py-3 pl-10 text-xs text-gray-500 italic">
            No products yet
          </div>
        </div>
      </div>
    </div>

    <!-- Add Product Button -->
    <div class="p-3 border-t border-gray-700">
      <button
        @click="$emit('add-product')"
        class="w-full py-2 px-3 bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium rounded transition-colors flex items-center justify-center gap-2"
      >
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
        </svg>
        Add Product
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

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

defineEmits(['select', 'add-product', 'delete-product'])

const productsExpanded = ref(true)
</script>
