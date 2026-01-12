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

    <!-- Text Color -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Text Color
      </label>
      <div class="flex gap-2">
        <input
          :value="product.textColor"
          @input="$emit('update', { field: 'textColor', value: $event.target.value })"
          type="color"
          class="h-10 w-16 rounded cursor-pointer bg-gray-700 border border-gray-600"
        />
        <input
          :value="product.textColor"
          @input="$emit('update', { field: 'textColor', value: $event.target.value })"
          type="text"
          class="flex-1 px-3 py-2 bg-gray-700 border border-gray-600 rounded text-sm text-gray-100 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          placeholder="#000000"
        />
      </div>
    </div>

    <!-- Font Size -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Font Size: {{ product.fontSize }}px
      </label>
      <input
        :value="product.fontSize"
        @input="$emit('update', { field: 'fontSize', value: parseInt($event.target.value) })"
        type="range"
        min="12"
        max="24"
        step="1"
        class="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-blue-500"
      />
      <div class="flex justify-between text-xs text-gray-500 mt-1">
        <span>12px</span>
        <span>24px</span>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  product: {
    type: Object,
    required: true
  }
})

defineEmits(['update'])
</script>
