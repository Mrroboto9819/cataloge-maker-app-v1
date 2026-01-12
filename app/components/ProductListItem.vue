<template>
  <div
    @click="$emit('edit')"
    :style="{
      cursor: 'pointer',
      borderRadius: '4px',
      padding: '8px 12px'
    }"
  >
    <div :style="{ display: 'flex', alignItems: 'flex-end', gap: '8px' }">
      <span
        :style="{
          whiteSpace: 'nowrap',
          fontWeight: '500',
          color: product.textColor || '#1F2937',
          fontSize: `${product.fontSize || 16}px`
        }"
      >
        {{ product.name || 'Product Name' }}
      </span>
      <span
        :style="{
          flex: '1',
          borderBottom: '2px dotted',
          borderColor: product.textColor || '#9CA3AF',
          opacity: 0.5
        }"
      ></span>
      <span
        :style="{
          whiteSpace: 'nowrap',
          fontWeight: '700',
          color: product.textColor || '#1F2937',
          fontSize: `${product.fontSize || 16}px`
        }"
      >
        ${{ product.price || '0.00' }}
      </span>
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

defineEmits(['edit'])
</script>
