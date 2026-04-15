<template>
  <dialog class="modal" :class="{ 'modal-open': open }">
    <div class="modal-box">

      <h3 class="font-bold text-lg mb-2">
        {{ event?.title }}
      </h3>

      <p>{{ event?.start?.toLocaleString() }}</p>

      <textarea
        class="textarea textarea-bordered w-full mt-3"
        v-model="notes"
        @input="updateNotes"
      />

      <div class="modal-action">
        <button class="btn btn-error"  @click="$emit('delete', { id: props.event.id })">
          Delete
        </button>

        <button class="btn" @click="$emit('close')">
          Close
        </button>
      </div>

    </div>
  </dialog>
</template>

<script setup>
import { ref, watch } from 'vue'

const props = defineProps({
  open: Boolean,
  event: Object
})

const emit = defineEmits(['close', 'delete', 'update-notes'])
const notes = ref('')

watch(() => props.event, (e) => {
  notes.value = e?.extendedProps?.notes || ''
})

const updateNotes = () => {
  emit('update-notes', {
    id: props.event.id,
    notes: notes.value
  })
}
</script>