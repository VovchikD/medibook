# frozen_string_literal: true

module DefaultWorkingHours
  DEFAULT_WORKING_HOURS = [
    { day: 'monday',    enabled: true,  start: '09:00', end: '17:00' },
    { day: 'tuesday',   enabled: true,  start: '09:00', end: '17:00' },
    { day: 'wednesday', enabled: true,  start: '09:00', end: '17:00' },
    { day: 'thursday',  enabled: true,  start: '09:00', end: '17:00' },
    { day: 'friday',    enabled: true,  start: '09:00', end: '17:00' },
    { day: 'saturday',  enabled: false, start: nil,     end: nil },
    { day: 'sunday',    enabled: false, start: nil,     end: nil }
  ]
end
