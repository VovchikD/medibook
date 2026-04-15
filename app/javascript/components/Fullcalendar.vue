
<template>
  <FullCalendar ref="calendarRef" :options="calendarOptions" />

  <CreateAppointmentModal
    :open="showCreateModal"
    :start="newEvent?.start"
    @close="showCreateModal = false"
    @save="saveCreate"
  />

  <DetailAppointment
    :open="showViewModal"
    :event="selectedEvent"
    @close="showViewModal = false"
    @update-notes="updateNotes"
    @delete="deleteEvent"
  />
</template>

<script setup>
import { ref } from 'vue'
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from '@fullcalendar/interaction'
import DetailAppointment from './modals/DetailAppointment.vue'
import CreateAppointmentModal from './modals/CreateAppointment.vue'

const emit = defineEmits([
  'create',
  'update',
  'delete',
  'update-notes'
])

const selectedEvent = ref(null)
const newEvent = ref(null)
const showViewModal = ref(false)
const showCreateModal = ref(false)
const notes = ref('')
const calendarRef = ref(null)


const props = defineProps({
  doctorId: Number
})

const handleDateClick = (info) => {
  const start = info.date
  const end = new Date(start.getTime() + 30 * 60000)

  newEvent.value = { start, end }
  showCreateModal.value = true
}

const saveCreate = ({ notes }) => {
  emit('create', {
    start: newEvent.value.start,
    end: newEvent.value.end,
    notes: notes
  })

  showCreateModal.value = false
}

const handleEventDrop = (info) => {
  emit('update', {
    id: info.event.id,
    start: info.event.start,
    end: info.event.end
  })
}

const deleteEvent = ({ id }) => {
  emit('delete', { id: id })
  showViewModal.value = false
}

const updateNotes = ({ id, notes }) => {
  emit('update-notes', {
    id: id,
    notes: notes
  })
}

const handleEventClick = (info) => {
  selectedEvent.value = info.event
  notes.value = info.event.extendedProps.notes
  showViewModal.value = true
}

const calendarOptions = {
  plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin],

  editable: true,
  initialView: 'dayGridMonth',
  dateClick: handleDateClick,
  eventClick: handleEventClick,
  eventDrop: handleEventDrop,

  headerToolbar: {
    left: 'prev,next today',
    center: 'title',
    right: 'dayGridMonth,timeGridWeek'
  },
  events: async (fetchInfo, successCallback) => {
    const res = await fetch(
      `/doctors/${props.doctorId}/appointments?start=${fetchInfo.startStr}&end=${fetchInfo.endStr}`
    )

    const data = await res.json()
    const events = data.map(a => ({
      id: a.id,
      title: a.patient_name,
      start: a.start_time,
      end: a.end_time,
      extendedProps: {
        notes: a.notes
      }
    }))

    successCallback(events)
  }
}

const refetchEvents = () => {
  calendarRef.value.getApi().refetchEvents()
}

defineExpose({
  refetchEvents
})
</script>
