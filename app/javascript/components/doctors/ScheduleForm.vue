<template>
    <div class="card bg-base-100 shadow m-6">

    <div class="card-body">

      <div 
        v-for="schedule in schedules"
        :key="schedule.day"
        class="flex justify-center items-center"
      >
        <input
          type="checkbox"
          class="checkbox"
          v-model="schedule.enabled"
        />

        <span class="w-20 capitalize">
          {{ schedule.day }}
        </span>

        <input
          type="time"
          class="input input-bordered input-sm"
          v-model="schedule.start"
          :disabled="!schedule.enabled"
        />

        <span>-</span>

        <input
          type="time"
          class="input input-bordered input-sm"
          v-model="schedule.end"
          :disabled="!schedule.enabled"
        />
      </div>

      <button @click="setupSchedules" class="btn btn-primary w-fit">
        + Schedule
      </button>
    </div>

  </div>
</template>

<script setup>
const props = defineProps({
  schedules: Array
})

const emit = defineEmits(['update'])

const setupSchedules = () => {
  emit('update', { schedules: props.schedules })
}
</script>
