
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
import { ref, onMounted } from 'vue'
import axios from 'axios'
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
const schedules = ref([])


const props = defineProps({
  doctorId: Number
})

const handleDateClick = (info) => {
  if (!isWithinSchedule(info.date)) return

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
  if (info.event.extendedProps.busy) return

  selectedEvent.value = info.event
  notes.value = info.event.extendedProps.notes
  showViewModal.value = true
}

const loadWorkingHours = async () => {
  const res = await axios.get(`/doctor_schedules/${props.doctorId}`)
  schedules.value = res.data

  calendarRef.value.getApi().setOption(
    'businessHours',
    mapToBusinessHours(schedules.value)
  )
}

const mapToBusinessHours = (schedules) => {
  return schedules
    .filter(s => s.enabled)
    .map(s => ({
      daysOfWeek: [dayMap[s.day]],
      startTime: s.start,
      endTime: s.end
    }))
}

const isWithinSchedule = (date) => {
  const day = date.getDay()
  const time = date.toTimeString()

  return schedules.value.some(s =>
    s.enabled &&
    dayMap[s.day] === day &&
    time >= s.start &&
    time < s.end
  )
}

const calendarOptions = {
  plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin],

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
      title: a.title,
      start: a.start_time,
      end: a.end_time,
      editable: !a.busy,
      backgroundColor: a.busy ? '#ef4444' : '',
      extendedProps: {
        notes: a.notes,
        busy: a.busy
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

onMounted(() => {
  loadWorkingHours()
})

const dayMap = {
  sunday: 0,
  monday: 1,
  tuesday: 2,
  wednesday: 3,
  thursday: 4,
  friday: 5,
  saturday: 6
}
</script>
