<script setup>
// useHead({
//   meta: [
//     { name: 'viewport', content: 'width=device-width, initial-scale=1' }
//   ],
//   link: [
//     { rel: 'icon', href: '/favicon.ico' }
//   ],
//   htmlAttrs: {
//     lang: 'en'
//   }
// })

// const title = 'Nuxt Starter Template'
// const description = 'A production-ready starter template powered by Nuxt UI. Build beautiful, accessible, and performant applications in minutes, not hours.'

// useSeoMeta({
//   title,
//   description,
//   ogTitle: title,
//   ogDescription: description,
//   ogImage: 'https://ui.nuxt.com/assets/templates/nuxt/starter-light.png',
//   twitterImage: 'https://ui.nuxt.com/assets/templates/nuxt/starter-light.png',
//   twitterCard: 'summary_large_image'
// })
</script>

<template>
  <NuxtPage />
  <div class="fixed bottom-2 right-2 text-[10px] text-gray-400/50 font-mono pointer-events-none z-50">
    v{{ config.public.appVersion }} · {{ config.public.buildId }}
  </div>
</template>

<script setup>
const config = useRuntimeConfig()
</script>
