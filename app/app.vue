<script setup>
const config = useRuntimeConfig()
</script>

<template>
  <NuxtPage />
  <div class="fixed bottom-2 right-2 text-[10px] text-gray-400/50 font-mono pointer-events-none z-50">
    v{{ config.public.appVersion }} · {{ config.public.buildId }}
  </div>
</template>
