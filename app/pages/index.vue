<template>
  <!-- Desktop Layout (3-column) -->
  <div class="hidden md:flex h-screen bg-gray-900">
    <!-- Left Panel: Layers -->
    <div class="w-64 flex-shrink-0 border-r border-gray-700">
      <LayersPanel
        :catalog="catalog"
        :selected="selectedElement"
        @select="handleSelect"
        @add-product="addProduct"
        @delete-product="deleteProduct"
      />
    </div>

    <!-- Center: Canvas Preview -->
    <div class="flex-1 flex flex-col bg-gray-700">
      <!-- Toolbar -->
      <div class="bg-gray-800 border-b border-gray-700 px-4 py-2.5 flex items-center justify-between">
        <h1 class="text-sm font-semibold text-gray-100">
          Product Catalog Maker V1.0.0
        </h1>
        <button
          @click="downloadCatalog"
          class="px-4 py-1.5 bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium rounded transition-colors flex items-center gap-2"
        >
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
          </svg>
          Export PNG
        </button>
      </div>

      <!-- Canvas Area -->
      <div class="flex-1 overflow-auto p-8 flex items-start justify-center">
        <CatalogCanvas
          ref="desktopCanvasRef"
          :catalog="catalog"
          :selected="selectedElement"
          @select="handleSelect"
        />
      </div>

      <!-- Status Bar -->
      <div class="bg-gray-800 border-t border-gray-700 px-4 py-2 flex items-center justify-between text-xs text-gray-400">
        <span>A4 Width: 794px | Height: Dynamic</span>
        <span>Products: {{ catalog.products.length }}</span>
      </div>
    </div>

    <!-- Right Panel: Properties -->
    <div class="w-80 flex-shrink-0 border-l border-gray-700 overflow-auto">
      <PropertiesPanel
        :selected="selectedElement"
        :catalog="catalog"
        @update="handleUpdate"
      />
    </div>
  </div>

  <!-- Mobile Layout (Canva-style) -->
  <div class="md:hidden flex flex-col bg-gray-900 overflow-hidden" style="height: 100vh; height: 100dvh;">
    <!-- Top Toolbar -->
    <div class="bg-gray-800 px-3 py-2 flex items-center justify-between border-b border-gray-700 flex-shrink-0 z-30">
      <button
        @click="mobileLayersOpen = !mobileLayersOpen"
        class="p-2 hover:bg-gray-700 rounded transition-colors"
        title="Layers"
      >
        <svg class="w-5 h-5 text-gray-100" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
        </svg>
      </button>

      <h1 class="text-xs font-semibold text-gray-100 truncate">Catalog Maker</h1>

      <button
        @click="downloadCatalog"
        class="p-2 hover:bg-gray-700 rounded transition-colors"
        title="Export"
      >
        <svg class="w-5 h-5 text-gray-100" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
        </svg>
      </button>
    </div>

    <!-- Full Screen Canvas -->
    <div class="flex-1 overflow-auto bg-gray-700 relative touch-pan-x touch-pan-y">
      <div class="min-w-max min-h-full flex items-center justify-center p-4">
        <div :style="{ transform: `scale(${mobileZoom})`, transformOrigin: 'center center', transition: 'transform 0.2s ease' }">
          <CatalogCanvas
            ref="mobileCanvasRef"
            :catalog="catalog"
            :selected="selectedElement"
            @select="handleSelect"
          />
        </div>
      </div>
    </div>

    <!-- Zoom Controls -->
    <div class="fixed bottom-4 right-4 flex flex-col gap-3 z-40">
      <!-- Zoom In -->
      <button
        @click="zoomIn"
        :disabled="mobileZoom >= 2"
        class="w-12 h-12 bg-gray-800 hover:bg-gray-700 disabled:opacity-50 disabled:cursor-not-allowed text-white rounded-full shadow-lg flex items-center justify-center transition-all"
        title="Zoom In"
      >
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0zM10 7v6m3-3H7" />
        </svg>
      </button>

      <!-- Zoom Out -->
      <button
        @click="zoomOut"
        :disabled="mobileZoom <= 0.25"
        class="w-12 h-12 bg-gray-800 hover:bg-gray-700 disabled:opacity-50 disabled:cursor-not-allowed text-white rounded-full shadow-lg flex items-center justify-center transition-all"
        title="Zoom Out"
      >
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0zM13 10H7" />
        </svg>
      </button>

      <!-- Properties FAB -->
      <button
        @click="mobilePropertiesOpen = true"
        :disabled="!selectedElement"
        class="w-12 h-12 bg-gray-800 hover:bg-gray-700 disabled:opacity-50 disabled:cursor-not-allowed text-white rounded-full shadow-lg flex items-center justify-center transition-all"
        title="Properties"
      >
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4" />
        </svg>
      </button>

      <!-- Add Product FAB -->
      <button
        @click="addProduct"
        class="w-12 h-12 bg-gray-800 hover:bg-gray-700 text-white rounded-full shadow-lg flex items-center justify-center transition-all"
        title="Add Product"
      >
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
        </svg>
      </button>
    </div>

    <!-- Mobile Layers Panel (Slide from left) -->
    <div
      class="fixed inset-y-0 left-0 w-64 max-w-[80vw] bg-gray-800 transform transition-transform duration-300 ease-in-out z-50 shadow-2xl"
      :class="mobileLayersOpen ? 'translate-x-0' : '-translate-x-full'"
      style="height: 100vh; height: 100dvh;"
    >
      <div class="h-full flex flex-col">
        <div class="px-4 py-3 border-b border-gray-700 flex items-center justify-between flex-shrink-0">
          <h3 class="text-sm font-semibold text-gray-100">Layers</h3>
          <button
            @click="mobileLayersOpen = false"
            class="p-1 hover:bg-gray-700 rounded transition-colors"
          >
            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
        <div class="flex-1 overflow-auto">
          <LayersPanel
            :catalog="catalog"
            :selected="selectedElement"
            @select="handleSelectMobile"
            @add-product="addProductMobile"
            @delete-product="deleteProduct"
          />
        </div>
      </div>
    </div>

    <!-- Mobile Properties Panel (Slide from right) -->
    <div
      class="fixed inset-y-0 right-0 w-80 max-w-[85vw] bg-gray-800 transform transition-transform duration-300 ease-in-out z-50 shadow-2xl"
      :class="mobilePropertiesOpen && selectedElement ? 'translate-x-0' : 'translate-x-full'"
      style="height: 100vh; height: 100dvh;"
    >
      <div class="h-full flex flex-col">
        <div class="px-4 py-3 border-b border-gray-700 flex items-center justify-between flex-shrink-0">
          <h3 class="text-sm font-semibold text-gray-100">{{ selectedElementLabel || 'Properties' }}</h3>
          <button
            @click="mobilePropertiesOpen = false"
            class="p-1 hover:bg-gray-700 rounded transition-colors"
          >
            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
        <div class="flex-1 overflow-auto">
          <PropertiesPanel
            :selected="selectedElement"
            :catalog="catalog"
            @update="handleUpdate"
          />
        </div>
      </div>
    </div>

    <!-- Backdrop overlay -->
    <div
      v-if="mobileLayersOpen || (mobilePropertiesOpen && selectedElement)"
      @click="closeAllMobilePanels"
      class="fixed inset-0 bg-[rgba(0,0,0,0.3)] z-40 transition-opacity"
    ></div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import * as htmlToImage from 'html-to-image'
import LayersPanel from '~/components/editor/LayersPanel.vue'
import PropertiesPanel from '~/components/editor/PropertiesPanel.vue'
import CatalogCanvas from '~/components/editor/CatalogCanvas.vue'

// Mobile panel states
const mobileLayersOpen = ref(false)
const mobilePropertiesOpen = ref(false)

// Mobile zoom state
const mobileZoom = ref(1) // 1 = 100%

// Catalog state
const catalog = ref({
  mode: 'grid',
  gridColumns: 2,
  title: 'Weekly Specials',
  subtitle: 'Fresh Deals This Week',
  titleColor: '#ffffff',
  subtitleColor: '#ffffff',
  titleSize: 36,
  subtitleSize: 20,
  backgroundImage: null,
  backgroundColor: '#ffffff',
  logo: {
    image: null,
    width: 200,
    height: 100,
    alignment: 'center', // 'left' | 'center' | 'right'
    marginBottom: 24
  },
  globalBadge: {
    overridePoints: false, // If true, use globalPoints for all badges
    globalPoints: 16 // Global spike count (8-24)
  },
  products: []
})

// Selection state
const selectedElement = ref(null)

// Computed label for selected element
const selectedElementLabel = computed(() => {
  if (!selectedElement.value) return ''

  switch (selectedElement.value.type) {
    case 'background':
      return 'Background & Display Mode'
    case 'logo':
      return 'Logo / Brand'
    case 'title':
      return 'Title'
    case 'subtitle':
      return 'Subtitle'
    case 'product':
      const product = catalog.value.products.find(p => p.id === selectedElement.value.id)
      return product?.name || 'Product'
    default:
      return ''
  }
})

// Close all mobile panels
const closeAllMobilePanels = () => {
  mobileLayersOpen.value = false
  mobilePropertiesOpen.value = false
}

// Mobile-specific handlers
const handleSelectMobile = (selection) => {
  selectedElement.value = selection
  mobileLayersOpen.value = false

  // Scroll to and center the selected product
  // COMMENTED OUT: Causing unwanted scroll behavior
  // if (selection?.type === 'product' && selection?.id) {
  //   setTimeout(() => {
  //     const productElement = document.querySelector(`[data-product-id="${selection.id}"]`)
  //     if (productElement) {
  //       productElement.scrollIntoView({
  //         behavior: 'smooth',
  //         block: 'center',
  //         inline: 'center'
  //       })
  //     }
  //   }, 100)
  // }

  if (selection) {
    mobilePropertiesOpen.value = true
  }
}

const addProductMobile = () => {
  addProduct()
  mobileLayersOpen.value = false
}

// Zoom functions
const zoomIn = () => {
  if (mobileZoom.value < 2) {
    mobileZoom.value = Math.min(2, mobileZoom.value + 0.25)
  }
}

const zoomOut = () => {
  if (mobileZoom.value > 0.25) {
    mobileZoom.value = Math.max(0.25, mobileZoom.value - 0.25)
  }
}

const resetZoom = () => {
  mobileZoom.value = 1
}

// Refs to catalog canvases (desktop and mobile)
const desktopCanvasRef = ref(null)
const mobileCanvasRef = ref(null)

// Handle selection
const handleSelect = (selection) => {
  selectedElement.value = selection

  // Scroll to and center the selected product
  // COMMENTED OUT: Causing unwanted scroll behavior
  // if (selection?.type === 'product' && selection?.id) {
  //   setTimeout(() => {
  //     const productElement = document.querySelector(`[data-product-id="${selection.id}"]`)
  //     if (productElement) {
  //       productElement.scrollIntoView({
  //         behavior: 'smooth',
  //         block: 'center',
  //         inline: 'center'
  //       })
  //     }
  //   }, 100)
  // }
}

// Handle property updates
const handleUpdate = (update) => {
  if (update.type === 'product') {
    // Update product
    const productIndex = catalog.value.products.findIndex(p => p.id === update.id)
    if (productIndex !== -1) {
      const product = catalog.value.products[productIndex]

      // Handle different update types
      if (update.field === 'badge') {
        product.badge = update.value
      } else {
        product[update.field] = update.value
      }

      // Trigger reactivity
      catalog.value.products = [...catalog.value.products]
    }
  } else {
    // Update catalog-level field (supports nested paths like 'globalBadge.overridePoints')
    const fieldPath = update.field.split('.')
    if (fieldPath.length === 1) {
      // Simple field
      catalog.value[update.field] = update.value
    } else {
      // Nested field
      let target = catalog.value
      for (let i = 0; i < fieldPath.length - 1; i++) {
        target = target[fieldPath[i]]
      }
      target[fieldPath[fieldPath.length - 1]] = update.value
    }
  }
}

// Create default product with all properties (unified for both modes)
const createDefaultProduct = () => {
  const id = `product-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`

  return {
    id,
    // Shared fields
    name: '',
    price: '',
    // Grid mode fields
    image: null,
    titleColor: '#ffffff',
    badge: {
      color: '#FFD700',
      priceColor: '#1F2937',
      points: 16,
      rotation: -15,
      position: 'bottom-right',
      customPosition: { x: 0, y: 0 },
      showExtraText: false,
      topText: '',
      bottomText: '',
      textColor: '#DC2626'
    },
    // List mode fields
    textColor: '#ffffff',
    fontSize: 16
  }
}

// Add product
const addProduct = () => {
  const newProduct = createDefaultProduct()
  catalog.value.products.push(newProduct)

  // Auto-select the new product
  selectedElement.value = { type: 'product', id: newProduct.id }
}

// Delete product
const deleteProduct = (productId) => {
  catalog.value.products = catalog.value.products.filter(p => p.id !== productId)

  // Clear selection if deleted product was selected
  if (selectedElement.value?.type === 'product' && selectedElement.value?.id === productId) {
    selectedElement.value = null
  }
}

// Download catalog
const downloadCatalog = async () => {
  // Determine which canvas ref to use (desktop or mobile)
  const canvasRef = desktopCanvasRef.value?.catalogContainer
    ? desktopCanvasRef
    : mobileCanvasRef.value?.catalogContainer
    ? mobileCanvasRef
    : null

  if (!canvasRef?.value?.catalogContainer) {
    alert('Catalog not ready. Please try again.')
    return
  }

  try {
    const element = canvasRef.value.catalogContainer

    // Temporarily hide selection rings for export
    const oldSelection = selectedElement.value
    selectedElement.value = null

    // Wait for render
    await new Promise(resolve => setTimeout(resolve, 100))

    // Use html-to-image with high quality settings
    const dataUrl = await htmlToImage.toPng(element, {
      cacheBust: true,
      pixelRatio: 3,  // 3x resolution for print quality
      width: 794,
      height: element.scrollHeight,
      style: {
        margin: '0',
        padding: '0'
      }
    })

    // Restore selection
    selectedElement.value = oldSelection

    // Download the image
    const link = document.createElement('a')
    link.href = dataUrl
    link.download = `catalog-${Date.now()}.png`
    link.click()

  } catch (error) {
    console.error('Error generating image:', error)
    alert('Error generating image: ' + error.message)

    // Restore selection on error
    selectedElement.value = oldSelection
  }
}
</script>
