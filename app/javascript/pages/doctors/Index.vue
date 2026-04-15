<template>
  <div
    v-for="doctor in doctors"
    :key="doctor.id"
    class="flex items-center justify-between"
  >
  <div class="card card-dash bg-base-100 w-96 m-6">
    <div class="card-body p-6 space-y-4">
        <p class="font-medium">
          {{ doctor.fullname }}
        </p>

        <button
          class="btn btn-primary btn-sm"
          @click.stop="goToDoctor(doctor.id)"
        >
          Schedule
        </button>
      </div>

    </div>
  </div>
</template>

<script setup>
import { router } from '@inertiajs/vue3'

const props = defineProps({
  doctors: Array
})

const goToDoctor = (id) => {
  router.visit(`/doctors/${id}`)
}
</script>
