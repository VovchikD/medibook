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
</script>
