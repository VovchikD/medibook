<template>
  <dialog class="modal" :class="{ 'modal-open': open }">
    <div class="modal-box">

      <h3 class="font-bold text-lg mb-2">
        Create Appointment
      </h3>

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
        placeholder="Notes..."
        v-model="notes"
      />

      <div v-if="doctors" class="mt-3">
        <select
          v-model="selectedDoctorId"
          class="select select-bordered w-full"
        >
          <option value="">Select doctor</option>

          <option
            v-for="doc in doctors"
            :key="doc.id"
            :value="doc.id"
          >
            {{ doc.fullname }}
          </option>
        </select>
      </div>

      <div class="modal-action">
        <button class="btn btn-primary" @click="saveCreate">
          Save
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
  start: Date,
  end: Date,
  doctors: Array
})

const emit = defineEmits(['save', 'close'])
const notes = ref('')
const localStart = ref(null)
const localEnd = ref(null)
const selectedDoctorId = ref('')

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
  const newStart = new Date(value)

  localStart.value = newStart
  localEnd.value = new Date(newStart.getTime() + 30 * 60000)
}

const saveCreate = () => {
  emit('save', {
    doctor_id: selectedDoctorId.value,
    start: localStart.value,
    end: localEnd.value,
    notes: notes.value
  })
}

watch(() => props.open, (val) => {
  if (val) {
    notes.value = ''

    if (props.start) {
      localStart.value = new Date(props.start)
    } else {
      localStart.value = new Date()
    }

    localEnd.value = new Date(localStart.value.getTime() + 30 * 60000)
  }
})
</script>
