<template>
  <dialog class="modal" :class="{ 'modal-open': open }">
    <div class="modal-box">

      <h3 class="font-bold text-lg mb-2">
        Create Appointment
      </h3>

      <p class="text-sm">
        {{ start?.toLocaleString() }}
      </p>

      <textarea
        class="textarea textarea-bordered w-full mt-3"
        placeholder="Notes..."
        v-model="notes"
      />

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
  end: Date
})

const emit = defineEmits(['save', 'close'])
const notes = ref('')

const saveCreate = () => {
  emit('save', {
    notes: notes.value
  })
}

watch(() => props.open, (val) => {
  if (val) {
    notes.value = ''
  }
})
</script>
