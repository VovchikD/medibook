<template>
  <div class="p-6 space-y-4">

    <div
      v-for="appointment in appointments"
      :key="appointment.id"
      class="card card-dash bg-base-100 w-full"
    >
      <div class="card-body p-6">

        <div class="flex justify-between items-center">
          <p class="font-medium">
            {{ appointment.doctor_name }}
          </p>

          <p class="text-sm opacity-70">
            {{ appointment.range_consultation }}
          </p>
        </div>

      </div>
    </div>

  </div>
</template>

<script setup>
const props = defineProps({
  appointments: Array
})
</script>
