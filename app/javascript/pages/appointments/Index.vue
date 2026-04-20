<template>
  <div class="p-6 space-y-4">
    <button @click="showCreateModal = true" class="btn btn-primary">
      + Appointment
    </button>

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

          <button @click="openEdit(appointment)" class="btn btn-primary mr-1">
            Edit
          </button>

          <button @click="deleteAppointment({ id: appointment.id })" class="btn btn-error">
            X
          </button>
        </div>

      </div>
    </div>

  </div>

  <CreateAppointmentModal
    :open="showCreateModal"
    :doctors="doctors"
    @close="showCreateModal = false"
    @save="createAppointment"
  />

  <EditAppointmentModal
    :open="showEditModal"
    :appointment="selectedAppointment"
    :doctors="doctors"
    @close="showEditModal = false"
    @update="updateAppointment"
  />
</template>

<script setup>
import axios from '../../lib/axios'
import { router } from '@inertiajs/vue3'
import { ref } from 'vue'
import CreateAppointmentModal from '../../components/modals/CreateAppointment.vue'
import EditAppointmentModal from '../../components/modals/EditAppointment.vue'

const showCreateModal = ref(false)
const showEditModal = ref(false)
const selectedAppointment = ref(null)

const props = defineProps({
  appointments: Array,
  doctors: Array
})

const createAppointment = async ({ doctor_id, start, end, notes }) => {
  await axios.post('/appointments', {
    doctor_id: doctor_id,
    start_time: start,
    end_time: end,
    notes: notes
  })

  showCreateModal.value = false
  router.reload()
}

const updateAppointment = async ({ id, doctor_id, start, end, notes }) => {
  await axios.patch(`/appointments/${id}`, {
    doctor_id,
    start_time: start.toISOString(),
    end_time: end.toISOString(),
    notes
  })

  showEditModal.value = false
  router.reload({ only: ['appointments'] })
}

const openEdit = (appointment) => {
  selectedAppointment.value = appointment
  showEditModal.value = true
}

const deleteAppointment = async ( { id }) => {
  await axios.delete(`/appointments/${id}`)

  router.reload()
}
</script>
