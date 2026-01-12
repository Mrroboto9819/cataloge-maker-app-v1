<template>
  <div class="p-4 space-y-4">
    <!-- Subtitle Text -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Subtitle Text
      </label>
      <input
        :value="catalog.subtitle"
        @input="$emit('update', { field: 'subtitle', value: $event.target.value })"
        type="text"
        placeholder="e.g., Fresh Deals This Week"
        class="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded text-sm text-gray-100 placeholder-gray-500 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
      />
    </div>

    <!-- Subtitle Color -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Color
      </label>
      <div class="flex gap-2">
        <input
          :value="catalog.subtitleColor"
          @input="$emit('update', { field: 'subtitleColor', value: $event.target.value })"
          type="color"
          class="h-10 w-16 rounded cursor-pointer bg-gray-700 border border-gray-600"
        />
        <input
          :value="catalog.subtitleColor"
          @input="$emit('update', { field: 'subtitleColor', value: $event.target.value })"
          type="text"
          class="flex-1 px-3 py-2 bg-gray-700 border border-gray-600 rounded text-sm text-gray-100 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          placeholder="#000000"
        />
      </div>
    </div>

    <!-- Subtitle Size -->
    <div>
      <label class="block text-xs font-medium text-gray-300 mb-2 uppercase tracking-wide">
        Size: {{ catalog.subtitleSize }}px
      </label>
      <input
        :value="catalog.subtitleSize"
        @input="$emit('update', { field: 'subtitleSize', value: parseInt($event.target.value) })"
        type="range"
        min="14"
        max="32"
        step="2"
        class="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-blue-500"
      />
      <div class="flex justify-between text-xs text-gray-500 mt-1">
        <span>14px</span>
        <span>32px</span>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  catalog: {
    type: Object,
    required: true
  }
})

defineEmits(['update'])
</script>
