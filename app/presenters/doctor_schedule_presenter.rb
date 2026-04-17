# frozen_string_literal: true

class DoctorSchedulePresenter
  def initialize(schedule)
    @schedule = schedule
  end

  def format_schedules
    {
      day: @schedule.day_of_week,
      enabled: @schedule.start_time.present?,
      start: @schedule.start_time&.strftime('%H:%M'),
      end: @schedule.end_time&.strftime('%H:%M')
    }
  end
end
