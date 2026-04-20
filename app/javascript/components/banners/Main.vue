<template>
  <div class="hero bg-base-200 min-h-screen">
    <div class="hero-content flex-col lg:flex-row">
      
      <img
        src="https://images.unsplash.com/photo-1576091160550-2173dba999ef?q=80&w=800&auto=format&fit=crop"
        class="max-w-sm rounded-2xl shadow-2xl border border-base-300"
      />

      <div>
        <h1 class="text-5xl font-bold">
          Book Your Doctor Appointment Easily
        </h1>

        <p class="py-6">
          Find trusted doctors and schedule appointments in just a few clicks. 
          Manage your visits, track your schedule, and get the care you need — 
          anytime, anywhere.
        </p>

        <Link href="/doctors" class="btn btn-primary">Book Appointment</Link>
      </div>

    </div>
  </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3'
</script>
