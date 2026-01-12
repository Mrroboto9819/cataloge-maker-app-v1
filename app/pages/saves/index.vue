<template>
  <div class="min-h-screen bg-gray-100 py-8 px-4">
    <div class="max-w-6xl mx-auto">
      <h1 class="text-3xl font-bold text-gray-800 mb-8 text-center">
        Product Announcement Maker
      </h1>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <!-- Editor Form -->
        <div class="bg-white rounded-lg shadow-md p-6">
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Edit Announcement</h2>

          <!-- Announcement Text -->
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Announcement Text
            </label>
            <input
              v-model="announcementText"
              type="text"
              placeholder="e.g., NEW ARRIVAL!"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            />
          </div>

          <!-- Text Color -->
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Text Color
            </label>
            <input
              v-model="textColor"
              type="color"
              class="w-full h-10 rounded border border-gray-300 cursor-pointer"
            />
          </div>

          <!-- Text Alignment -->
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Text Alignment
            </label>
            <div class="flex gap-2">
              <button
                @click="textAlign = 'start'"
                :class="[
                  'flex-1 py-2 px-4 rounded-lg border-2 transition-colors',
                  textAlign === 'start'
                    ? 'border-blue-500 bg-blue-50 text-blue-700'
                    : 'border-gray-300 hover:border-gray-400'
                ]"
              >
                Start
              </button>
              <button
                @click="textAlign = 'center'"
                :class="[
                  'flex-1 py-2 px-4 rounded-lg border-2 transition-colors',
                  textAlign === 'center'
                    ? 'border-blue-500 bg-blue-50 text-blue-700'
                    : 'border-gray-300 hover:border-gray-400'
                ]"
              >
                Center
              </button>
              <button
                @click="textAlign = 'end'"
                :class="[
                  'flex-1 py-2 px-4 rounded-lg border-2 transition-colors',
                  textAlign === 'end'
                    ? 'border-blue-500 bg-blue-50 text-blue-700'
                    : 'border-gray-300 hover:border-gray-400'
                ]"
              >
                End
              </button>
            </div>
          </div>

          <!-- Background Type -->
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Background Type
            </label>
            <div class="flex gap-2">
              <button
                @click="backgroundType = 'gradient'"
                :class="[
                  'flex-1 py-2 px-4 rounded-lg border-2 transition-colors',
                  backgroundType === 'gradient'
                    ? 'border-blue-500 bg-blue-50 text-blue-700'
                    : 'border-gray-300 hover:border-gray-400'
                ]"
              >
                Gradient
              </button>
              <button
                @click="backgroundType = 'solid'"
                :class="[
                  'flex-1 py-2 px-4 rounded-lg border-2 transition-colors',
                  backgroundType === 'solid'
                    ? 'border-blue-500 bg-blue-50 text-blue-700'
                    : 'border-gray-300 hover:border-gray-400'
                ]"
              >
                Solid
              </button>
            </div>
          </div>

          <!-- Background Colors -->
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Background Color{{ backgroundType === 'gradient' ? 's' : '' }}
            </label>
            <div class="flex gap-3">
              <div class="flex-1">
                <label class="block text-xs text-gray-600 mb-1">
                  {{ backgroundType === 'gradient' ? 'Color 1' : 'Color' }}
                </label>
                <input
                  v-model="bgColor1"
                  type="color"
                  class="w-full h-10 rounded border border-gray-300 cursor-pointer"
                />
              </div>
              <div v-if="backgroundType === 'gradient'" class="flex-1">
                <label class="block text-xs text-gray-600 mb-1">
                  Color 2
                </label>
                <input
                  v-model="bgColor2"
                  type="color"
                  class="w-full h-10 rounded border border-gray-300 cursor-pointer"
                />
              </div>
            </div>
          </div>

          <!-- Logo Upload -->
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Logo (Optional)
            </label>
            <div class="flex items-center justify-center w-full">
              <label
                class="flex flex-col items-center justify-center w-full h-24 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100 transition-colors"
              >
                <div class="flex flex-col items-center justify-center py-3">
                  <svg
                    class="w-6 h-6 mb-1 text-gray-500"
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
                  <p class="text-xs text-gray-500">
                    <span class="font-semibold">Upload logo</span>
                  </p>
                </div>
                <input
                  type="file"
                  class="hidden"
                  accept="image/*"
                  @change="handleLogoUpload"
                />
              </label>
            </div>
            <button
              v-if="logoImage"
              @click="logoImage = null"
              class="mt-2 text-xs text-red-600 hover:text-red-700"
            >
              Remove logo
            </button>
          </div>

          <!-- Product Image Upload -->
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Product Image
            </label>
            <div class="flex items-center justify-center w-full">
              <label
                class="flex flex-col items-center justify-center w-full h-32 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100 transition-colors"
              >
                <div class="flex flex-col items-center justify-center pt-5 pb-6">
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
                  <p class="text-xs text-gray-500">PNG, JPG</p>
                </div>
                <input
                  type="file"
                  class="hidden"
                  accept="image/*"
                  @change="handleFileUpload"
                />
              </label>
            </div>
          </div>

          <!-- Price -->
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">
              Price
            </label>
            <input
              v-model="price"
              type="text"
              placeholder="e.g., 29.99"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            />
          </div>

          <!-- Starburst Badge Settings -->
          <div class="mb-4 p-4 bg-gray-50 rounded-lg border border-gray-200">
            <h3 class="text-sm font-semibold text-gray-800 mb-3">Badge Customization</h3>

            <!-- Badge Color -->
            <div class="mb-3">
              <label class="block text-xs font-medium text-gray-600 mb-1">
                Badge Color
              </label>
              <input
                v-model="badgeColor"
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
                v-model="priceColor"
                type="color"
                class="w-full h-10 rounded border border-gray-300 cursor-pointer"
              />
            </div>

            <!-- Number of Points -->
            <div class="mb-3">
              <label class="block text-xs font-medium text-gray-600 mb-1">
                Number of Points: {{ badgePoints }}
              </label>
              <input
                v-model.number="badgePoints"
                type="range"
                min="8"
                max="32"
                step="2"
                class="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-blue-600"
              />
              <div class="flex justify-between text-xs text-gray-500 mt-1">
                <span>8</span>
                <span>32</span>
              </div>
            </div>

            <!-- Rotation Control -->
            <div class="mb-3">
              <label class="block text-xs font-medium text-gray-600 mb-1">
                Rotation: {{ badgeRotation }}°
              </label>
              <input
                v-model.number="badgeRotation"
                type="range"
                min="-180"
                max="180"
                step="5"
                class="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-blue-600"
              />
              <div class="flex justify-between text-xs text-gray-500 mt-1">
                <span>-180°</span>
                <span>0°</span>
                <span>180°</span>
              </div>
            </div>

            <!-- Show Extra Text Toggle -->
            <div class="mb-3">
              <label class="flex items-center cursor-pointer">
                <input
                  v-model="showExtraText"
                  type="checkbox"
                  class="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-2 focus:ring-blue-500"
                />
                <span class="ml-2 text-xs font-medium text-gray-600">
                  Show Extra Text (Top/Bottom)
                </span>
              </label>
            </div>

            <!-- Extra Text Section (only when enabled) -->
            <div v-if="showExtraText" class="mb-3 p-3 bg-white rounded border border-gray-200">
              <!-- Badge Text Color -->
              <div class="mb-3">
                <label class="block text-xs font-medium text-gray-600 mb-1">
                  Extra Text Color
                </label>
                <input
                  v-model="badgeTextColor"
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
                  v-model="badgeTopText"
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
                  v-model="badgeBottomText"
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
                  @click="badgePositionMode = 'relative'"
                  :class="[
                    'flex-1 py-2 px-3 rounded-lg border-2 transition-colors text-sm',
                    badgePositionMode === 'relative'
                      ? 'border-blue-500 bg-blue-50 text-blue-700'
                      : 'border-gray-300 hover:border-gray-400'
                  ]"
                >
                  Relative
                </button>
                <button
                  @click="badgePositionMode = 'absolute'"
                  :class="[
                    'flex-1 py-2 px-3 rounded-lg border-2 transition-colors text-sm',
                    badgePositionMode === 'absolute'
                      ? 'border-blue-500 bg-blue-50 text-blue-700'
                      : 'border-gray-300 hover:border-gray-400'
                  ]"
                >
                  Absolute
                </button>
              </div>
            </div>

            <!-- Relative Position Controls -->
            <div v-if="badgePositionMode === 'relative'" class="mb-0">
              <label class="block text-xs font-medium text-gray-600 mb-2">
                Horizontal Alignment
              </label>
              <div class="flex gap-2">
                <button
                  @click="priceAlign = 'start'"
                  :class="[
                    'flex-1 py-2 px-3 rounded-lg border-2 transition-colors text-sm',
                    priceAlign === 'start'
                      ? 'border-blue-500 bg-blue-50 text-blue-700'
                      : 'border-gray-300 hover:border-gray-400'
                  ]"
                >
                  Left
                </button>
                <button
                  @click="priceAlign = 'center'"
                  :class="[
                    'flex-1 py-2 px-3 rounded-lg border-2 transition-colors text-sm',
                    priceAlign === 'center'
                      ? 'border-blue-500 bg-blue-50 text-blue-700'
                      : 'border-gray-300 hover:border-gray-400'
                  ]"
                >
                  Center
                </button>
                <button
                  @click="priceAlign = 'end'"
                  :class="[
                    'flex-1 py-2 px-3 rounded-lg border-2 transition-colors text-sm',
                    priceAlign === 'end'
                      ? 'border-blue-500 bg-blue-50 text-blue-700'
                      : 'border-gray-300 hover:border-gray-400'
                  ]"
                >
                  Right
                </button>
              </div>
            </div>

            <!-- Absolute Position Controls -->
            <div v-if="badgePositionMode === 'absolute'" class="mb-0">
              <label class="block text-xs font-medium text-gray-600 mb-2">
                Move Badge (X: {{ badgeX }}px, Y: {{ badgeY }}px)
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
                  @click="badgeX = 0; badgeY = 0"
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

          <!-- Download Buttons -->
          <div class="flex gap-3">
            <button
              @click="downloadAsImage('png')"
              class="flex-1 bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-lg transition-colors"
            >
              Download PNG
            </button>
            <!-- <button
              @click="downloadAsImage('jpg')"
              class="flex-1 bg-green-600 hover:bg-green-700 text-white font-medium py-2 px-4 rounded-lg transition-colors"
            >
              Download JPG
            </button> -->
          </div>
        </div>

        <!-- Preview -->
        <div class="bg-white rounded-lg shadow-md p-6 lg:sticky lg:top-8 lg:self-start">
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Preview</h2>

          <div class="border-2 border-gray-200 rounded-lg overflow-hidden">
            <!-- Announcement Card Template -->
            <div
              ref="announcementCard"
              data-announcement-card
              :style="{
                ...backgroundStyle,
                padding: '32px',
                minHeight: '500px',
                display: 'flex',
                flexDirection: 'column',
                position: 'relative'
              }"
            >
              <!-- Logo -->
              <div
                v-if="logoImage"
                :style="{
                  position: 'absolute',
                  top: '16px',
                  left: '16px'
                }"
              >
                <img
                  :src="logoImage"
                  alt="Logo"
                  :style="{
                    height: '48px',
                    width: 'auto',
                    objectFit: 'contain'
                  }"
                />
              </div>

              <!-- Top Text -->
              <div
                :style="{
                  color: textColor,
                  fontWeight: '700',
                  fontSize: '30px',
                  marginBottom: '24px',
                  marginTop: logoImage ? '64px' : '0',
                  textAlign: textAlign === 'start' ? 'left' : textAlign === 'center' ? 'center' : 'right'
                }"
              >
                {{ announcementText || 'YOUR TEXT HERE' }}
              </div>

              <!-- Product Image -->
              <div :style="{
                flex: '1',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                margin: '24px 0'
              }">
                <div v-if="productImage" :style="{ maxWidth: '100%', maxHeight: '320px' }">
                  <img
                    :src="productImage"
                    alt="Product"
                    :style="{
                      maxWidth: '100%',
                      maxHeight: '320px',
                      borderRadius: '8px',
                      boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)'
                    }"
                  />
                </div>
                <div v-else :style="{ textAlign: 'center', color: '#ffffff' }">
                  <svg
                    :style="{
                      width: '96px',
                      height: '96px',
                      margin: '0 auto 16px auto',
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
                  <p :style="{ fontSize: '18px', opacity: '0.75' }">Upload product image</p>
                </div>
              </div>

              <!-- Price Badge - Starburst -->
              <div
                :style="
                  badgePositionMode === 'absolute'
                    ? {
                        position: 'absolute',
                        left: `${badgeX}px`,
                        top: `${badgeY}px`,
                        width: '180px',
                        height: '180px'
                      }
                    : {
                        display: 'flex',
                        justifyContent: priceAlign === 'start' ? 'flex-start' : priceAlign === 'center' ? 'center' : 'flex-end'
                      }
                "
              >
                <div
                  :style="{
                    position: 'relative',
                    width: '180px',
                    height: '180px',
                    transform: `rotate(${badgeRotation}deg)`
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
                    <!-- Dynamic rounded starburst -->
                    <path
                      :fill="badgeColor"
                      :d="starburstPath"
                      filter="drop-shadow(0 4px 6px rgba(0,0,0,0.2))"
                    />
                  </svg>

                  <!-- Price Text Content -->
                  <div :style="{
                    position: 'absolute',
                    top: '0',
                    left: '0',
                    width: '180px',
                    height: '180px',
                    display: 'table',
                    zIndex: '10'
                  }">
                    <div :style="{
                      display: 'table-cell',
                      verticalAlign: 'middle',
                      textAlign: 'center'
                    }">
                      <div
                        v-if="showExtraText && badgeTopText"
                        :style="{
                          color: badgeTextColor,
                          fontSize: '12px',
                          fontWeight: '700',
                          textTransform: 'uppercase',
                          letterSpacing: '0.05em',
                          margin: '0',
                          padding: '0',
                          lineHeight: '1.2'
                        }"
                      >
                        {{ badgeTopText }}
                      </div>
                      <div :style="{
                        color: priceColor,
                        fontSize: '28px',
                        fontWeight: '900',
                        lineHeight: '1',
                        margin: '4px 0',
                        padding: '0'
                      }">
                        ${{ price || '0.00' }}
                      </div>
                      <div
                        v-if="showExtraText && badgeBottomText"
                        :style="{
                          color: badgeTextColor,
                          fontSize: '12px',
                          fontWeight: '700',
                          textTransform: 'uppercase',
                          letterSpacing: '0.05em',
                          margin: '0',
                          padding: '0',
                          lineHeight: '1.2'
                        }"
                      >
                        {{ badgeBottomText }}
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import html2canvas from 'html2canvas'

const announcementText = ref('')
const textAlign = ref('center')
const textColor = ref('#ffffff')
const productImage = ref(null)
const price = ref('')
const priceAlign = ref('end')
const announcementCard = ref(null)
const backgroundType = ref('gradient')
const bgColor1 = ref('#3b82f6')
const bgColor2 = ref('#9333ea')
const logoImage = ref(null)
const badgeColor = ref('#FFD700')
const badgeTopText = ref('')
const badgeBottomText = ref('')
const badgePositionMode = ref('relative')
const badgeX = ref(0)
const badgeY = ref(0)
const priceColor = ref('#1F2937')
const badgeTextColor = ref('#DC2626')
const showExtraText = ref(false)
const badgePoints = ref(16)
const badgeRotation = ref(-15)

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
      // Add quadratic curve for smooth, rounded edges
      const prevAngle = (i - 1) * (angleStep / 2) - Math.PI / 2
      const prevRadius = (i - 1) % 2 === 0 ? outerRadius : innerRadius
      const prevX = centerX + Math.cos(prevAngle) * prevRadius
      const prevY = centerY + Math.sin(prevAngle) * prevRadius

      // Control point for the curve
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
  return generateRoundedStarburst(badgePoints.value, 85, 60)
})

const backgroundStyle = computed(() => {
  if (backgroundType.value === 'solid') {
    return {
      background: bgColor1.value
    }
  } else {
    return {
      background: `linear-gradient(to bottom right, ${bgColor1.value}, ${bgColor2.value})`
    }
  }
})

const handleFileUpload = (event) => {
  const file = event.target.files[0]
  if (file && file.type.startsWith('image/')) {
    const reader = new FileReader()
    reader.onload = (e) => {
      productImage.value = e.target.result
    }
    reader.readAsDataURL(file)
  }
}

const handleLogoUpload = (event) => {
  const file = event.target.files[0]
  if (file && file.type.startsWith('image/')) {
    const reader = new FileReader()
    reader.onload = (e) => {
      logoImage.value = e.target.result
    }
    reader.readAsDataURL(file)
  }
}

const moveBadge = (direction) => {
  const step = 10 // pixels to move per click
  switch (direction) {
    case 'up':
      badgeY.value -= step
      break
    case 'down':
      badgeY.value += step
      break
    case 'left':
      badgeX.value -= step
      break
    case 'right':
      badgeX.value += step
      break
  }
}

const downloadAsImage = async (format) => {
  if (!announcementCard.value) return

  try {
    const element = announcementCard.value

    // Create canvas with html2canvas
    const canvas = await html2canvas(element, {
      scale: 3,
      useCORS: true,
      allowTaint: true,
      backgroundColor: null,
      logging: false,
      onclone: (clonedDoc) => {
        // Ensure the cloned element maintains its styles
        const clonedElement = clonedDoc.querySelector('[data-announcement-card]')
        if (clonedElement) {
          clonedElement.style.transform = 'none'
        }
      }
    })

    // Convert to blob and download
    canvas.toBlob((blob) => {
      if (!blob) {
        alert('Error generating image. Please try again.')
        return
      }

      const url = URL.createObjectURL(blob)
      const link = document.createElement('a')
      link.href = url
      link.download = `announcement-${Date.now()}.${format}`
      link.click()
      URL.revokeObjectURL(url)
    }, format === 'png' ? 'image/png' : 'image/jpeg', 0.98)

  } catch (error) {
    console.error('Error generating image:', error)
    alert('Error generating image: ' + error.message)
  }
}
</script>