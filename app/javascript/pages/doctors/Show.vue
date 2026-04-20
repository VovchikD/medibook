<template>
  <Fullcalendar
    ref="calendarRef"
    :doctor-id="props.doctor.id"
    @create="createAppointment"
    @update="updateAppointment"
    @update-notes="updateNotes"
    @delete="deleteAppointment"
  />
</template>

<script setup>
import Fullcalendar from '../../components/Fullcalendar.vue';
import { ref } from 'vue'
import axios from '../../lib/axios'

const calendarRef = ref(null)

const props = defineProps({
  doctor: Object
})

const createAppointment = async ({ start, end, notes }) => {
  await axios.post('/appointments', {
    doctor_id: props.doctor.id,
    start_time: start,
    end_time: end,
    notes: notes
  })

  calendarRef.value.refetchEvents()
}

const updateAppointment = async (data) => {
  await axios.patch(`/appointments/${data.id}`, {
    start_time: data.start,
    end_time: data.end,
    notes: data.notes
  })

  calendarRef.value.refetchEvents()
}

const updateNotes = async ({ id, notes }) => {
  await axios.patch(`/appointments/${id}`, {
    notes: notes
  })

  calendarRef.value.refetchEvents()
}

const deleteAppointment = async ( { id }) => {
  await axios.delete(`/appointments/${id}`)

  calendarRef.value.refetchEvents()
}
</script>
