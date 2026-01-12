<template>
  <div
    @click="$emit('edit')"
    :style="{
      backgroundColor: 'transparent',
      cursor: 'pointer',
      padding: '16px',
      borderRadius: '8px',
      position: 'relative',
      overflow: 'visible'
    }"
  >
    <!-- Product Image (Fixed Size Container) -->
    <div
      :style="{
        position: 'relative',
        marginBottom: '12px',
        overflow: 'visible',
        borderRadius: '8px',
        width: '100%',
        height: '180px',
        backgroundColor: product.image ? 'transparent' : '#f3f4f6',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center'
      }"
    >
      <img
        v-if="product.image"
        :src="product.image"
        :alt="product.name"
        :style="{
          maxWidth: '100%',
          maxHeight: '100%',
          width: 'auto',
          height: 'auto',
          objectFit: 'contain',
          display: 'block'
        }"
      />
      <div v-else :style="{ textAlign: 'center', color: '#9ca3af' }">
        <svg
          :style="{
            width: '64px',
            height: '64px',
            margin: '0 auto 8px auto',
            opacity: '0.5'
          }"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"
          />
        </svg>
        <p :style="{ fontSize: '12px' }">No image</p>
      </div>

      <!-- Price Badge - Starburst (now inside image container) -->
      <div
        :style="{
          position: 'absolute',
          left: badgePosition.left,
          top: badgePosition.top,
          right: badgePosition.right,
          bottom: badgePosition.bottom,
          width: '120px',
          height: '120px',
          transform: badgePosition.transform,
          pointerEvents: 'none'
        }"
      >
      <div
        :style="{
          position: 'absolute',
          top: '0',
          left: '0',
          width: '120px',
          height: '120px',
          transform: `rotate(${product.badge.rotation}deg)`,
          transformOrigin: 'center center'
        }"
      >
        <!-- Starburst SVG -->
        <svg
          viewBox="0 0 200 200"
          :style="{
            position: 'absolute',
            top: '0',
            left: '0',
            width: '100%',
            height: '100%'
          }"
        >
          <path
            :fill="product.badge.color"
            :d="starburstPath"
            filter="drop-shadow(0 4px 6px rgba(0,0,0,0.2))"
          />
        </svg>

        <!-- Price Text Content -->
        <div :style="{
          position: 'absolute',
          top: '50%',
          left: '50%',
          transform: 'translate(-50%, -50%)',
          width: '100px',
          textAlign: 'center',
          zIndex: '10'
        }">
            <div
              v-if="product.badge.showExtraText && product.badge.topText"
              :style="{
                color: product.badge.textColor,
                fontSize: '10px',
                fontWeight: '700',
                textTransform: 'uppercase',
                letterSpacing: '0.05em',
                lineHeight: '1.2'
              }"
            >
              {{ product.badge.topText }}
            </div>
            <div :style="{
              color: product.badge.priceColor,
              fontSize: '20px',
              fontWeight: '900',
              lineHeight: '1',
              margin: '2px 0'
            }">
              ${{ product.price || '0.00' }}
            </div>
            <div
              v-if="product.badge.showExtraText && product.badge.bottomText"
              :style="{
                color: product.badge.textColor,
                fontSize: '10px',
                fontWeight: '700',
                textTransform: 'uppercase',
                letterSpacing: '0.05em',
                lineHeight: '1.2'
              }"
            >
              {{ product.badge.bottomText }}
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Product Name -->
    <h3
      :style="{
        textAlign: 'center',
        fontWeight: '600',
        fontSize: '14px',
        marginBottom: '8px',
        overflow: 'hidden',
        textOverflow: 'ellipsis',
        whiteSpace: 'nowrap',
        color: product.titleColor || '#374151'
      }"
    >
      {{ product.name || 'Product Name' }}
    </h3>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  product: {
    type: Object,
    required: true
  },
  catalog: {
    type: Object,
    required: true
  }
})

defineEmits(['edit'])

const badgePosition = computed(() => {
  const preset = props.product.badge.position || 'bottom-right'

  // Position badge center at container corners using percentages
  // 0,0 = top-left, 1,0 = top-right, 0,1 = bottom-left, 1,1 = bottom-right
  const presets = {
    'top-left': {
      top: '0%',
      left: '0%',
      right: 'auto',
      bottom: 'auto',
      transform: 'translate(-50%, -50%)'
    },
    'top-right': {
      top: '0%',
      left: '100%',
      right: 'auto',
      bottom: 'auto',
      transform: 'translate(-50%, -50%)'
    },
    'bottom-left': {
      top: '100%',
      left: '0%',
      right: 'auto',
      bottom: 'auto',
      transform: 'translate(-50%, -50%)'
    },
    'bottom-right': {
      top: '100%',
      left: '100%',
      right: 'auto',
      bottom: 'auto',
      transform: 'translate(-50%, -50%)'
    },
    'custom': {
      top: `${props.product.badge.customPosition?.y || 0}px`,
      left: `${props.product.badge.customPosition?.x || 0}px`,
      right: 'auto',
      bottom: 'auto',
      transform: 'translate(-50%, -50%)'
    }
  }

  return presets[preset] || presets['bottom-right']
})

const generateRoundedStarburst = (points, outerRadius, innerRadius) => {
  const centerX = 100
  const centerY = 100
  const angleStep = (Math.PI * 2) / points

  let path = ''

  for (let i = 0; i < points * 2; i++) {
    const angle = i * (angleStep / 2) - Math.PI / 2
    const radius = i % 2 === 0 ? outerRadius : innerRadius
    const x = centerX + Math.cos(angle) * radius
    const y = centerY + Math.sin(angle) * radius

    if (i === 0) {
      path += `M ${x} ${y}`
    } else {
      const prevAngle = (i - 1) * (angleStep / 2) - Math.PI / 2
      const prevRadius = (i - 1) % 2 === 0 ? outerRadius : innerRadius

      const controlAngle = (angle + prevAngle) / 2
      const controlRadius = (radius + prevRadius) / 2
      const controlX = centerX + Math.cos(controlAngle) * controlRadius
      const controlY = centerY + Math.sin(controlAngle) * controlRadius

      path += ` Q ${controlX} ${controlY} ${x} ${y}`
    }
  }

  path += ' Z'
  return path
}

const starburstPath = computed(() => {
  // Use global points if override is enabled, otherwise use product's individual points
  const points = props.catalog.globalBadge?.overridePoints
    ? props.catalog.globalBadge.globalPoints
    : props.product.badge.points
  return generateRoundedStarburst(points, 85, 60)
})
</script>
