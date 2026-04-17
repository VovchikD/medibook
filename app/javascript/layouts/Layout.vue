<template>
  <div class="min-h-screen bg-base-200">
    <Header />
    <main>
      <slot />
    </main>
  </div>
</template>

<script setup>
import Header from '../components/Header.vue'
import { watch } from 'vue'
import { toast } from 'vue3-toastify'
import 'vue3-toastify/dist/index.css'
import { usePage } from '@inertiajs/vue3'

const page = usePage()

watch(
  () => page.props?.flash?.alert ?? null,
  (alert) => {
    if (alert) toast.error(alert)
  },
  { immediate: true }
)
</script>
