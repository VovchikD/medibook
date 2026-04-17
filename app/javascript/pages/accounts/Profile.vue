<template>
  <ScheduleForm
    v-show="isDoctor"
    :schedules="schedules"
    @update="setupSchedules"
  />
</template>

<script setup>
import axios from 'axios'
import { ref, onMounted } from 'vue';
import ScheduleForm from '../../components/doctors/ScheduleForm.vue';

const schedules = ref([])

const props = defineProps({
  id: Number,
  isDoctor: Boolean
})

const loadWorkingHours = async () => {
  const res = await axios.get(`/doctor_schedules/${props.id}`)
  schedules.value = res.data
}

const setupSchedules = async ({ schedules }) => {
  console.log('setupSchedules')
  await axios.put('/doctor_schedules/bulk_update', { schedules: schedules })

  loadWorkingHours()
}

onMounted(() => {
  loadWorkingHours()
})
</script>
