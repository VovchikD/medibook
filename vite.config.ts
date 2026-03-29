import inertia from '@inertiajs/vite'
import vue from '@vitejs/plugin-vue'
import tailwindcss from '@tailwindcss/vite'
import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'

export default defineConfig({
  plugins: [
    inertia(),
    vue(),
    tailwindcss(),
    RubyPlugin(),
  ],
})
