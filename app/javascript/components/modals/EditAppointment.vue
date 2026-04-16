<template>
  <dialog class="modal" :class="{ 'modal-open': open }">
    <div class="modal-box">

      <h3 class="font-bold text-lg mb-2">
        Edit Appointment
      </h3>

      <div v-if="doctors?.length" class="mt-3">
        <label class="label">
          <span class="label-text">Doctor</span>
        </label>

        <select
          v-model="selectedDoctorId"
          class="select select-bordered w-full"
        >
          <option
            v-for="doc in doctors"
            :key="doc.id"
            :value="doc.id"
          >
            {{ doc.fullname }}
          </option>
        </select>
      </div>

      <input
        type="datetime-local"
        class="input input-bordered w-full mt-3"
        :value="formatDateTime(localStart)"
        @input="onDateTimeChange($event.target.value)"
      />

      <p class="text-sm text-gray-500">
        Ends at: {{ localEnd?.toLocaleTimeString() }}
      </p>

      <textarea
        class="textarea textarea-bordered w-full mt-3"
        v-model="notes"
      />

      <div class="modal-action">
        <button class="btn btn-primary" @click="updateEvent">
          Update
        </button>

        <button class="btn" @click="$emit('close')">
          Cancel
        </button>
      </div>

    </div>
  </dialog>
</template>

<script setup>
import { ref, watch } from 'vue'

const props = defineProps({
  open: Boolean,
  appointment: Object,
  doctors: Array
})

const emit = defineEmits(['update', 'close'])

const localStart = ref(null)
const localEnd = ref(null)
const notes = ref('')
const selectedDoctorId = ref(null)

const DURATION = 30

const formatDateTime = (date) => {
  if (!date) return ''

  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, '0')
  const day = String(date.getDate()).padStart(2, '0')
  const hours = String(date.getHours()).padStart(2, '0')
  const minutes = String(date.getMinutes()).padStart(2, '0')

  return `${year}-${month}-${day}T${hours}:${minutes}`
}

const onDateTimeChange = (value) => {
  const start = new Date(value)

  localStart.value = start
  localEnd.value = new Date(start.getTime() + DURATION * 60000)
}

const updateEvent = () => {
  emit('update', {
    id: props.appointment.id,
    doctor_id: selectedDoctorId.value,
    start: localStart.value,
    end: localEnd.value,
    notes: notes.value
  })
}

watch(() => props.open, (val) => {
  if (val && props.appointment) {
    localStart.value = new Date(props.appointment.start_time)
    localEnd.value = new Date(props.appointment.end_time)
    notes.value = props.appointment.notes || ''
    selectedDoctorId.value = props.appointment.doctor_id
  }
})
</script>
