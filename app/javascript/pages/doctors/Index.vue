<template>
  <div class="p-6 space-y-4">

    <div
      v-for="doctor in doctors"
      :key="doctor.id"
      class="card card-dash bg-base-100 w-full"
    >
      <div class="card-body p-6">

        <div class="flex justify-between items-center">
          <p class="font-medium">
            {{ doctor.fullname }}
          </p>

          <button
            class="btn btn-primary btn-sm"
            @click="goToDoctor(doctor.id)"
          >
            Schedule
          </button>
        </div>

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
