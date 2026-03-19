// https://nuxt.com/docs/api/configuration/nuxt-config
import tailwindcss from "@tailwindcss/vite";
import pkg from './package.json';

export default defineNuxtConfig({
  modules: [
    '@nuxt/eslint',
    // '@nuxt/ui'
  ],

  runtimeConfig: {
    public: {
      appVersion: pkg.version,
      buildId: process.env.BUILD_ID || 'dev',
    },
  },

  devtools: {
    enabled: true
  },

  css: ['~/assets/css/main.css'],

  routeRules: {
    '/': { prerender: true }
  },
  
  vite: {
    plugins: [
      tailwindcss(),
    ],
  },

  compatibilityDate: '2025-01-15',

  eslint: {
    config: {
      stylistic: {
        commaDangle: 'never',
        braceStyle: '1tbs'
      }
    }
  }
})
