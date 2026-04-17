# frozen_string_literal: true

class BusyAppointmentPresenter
  def initialize(appointment)
    @appointment = appointment
  end

  def as_json(*)
    {
      id: @appointment.id,
      title: 'Busy slot',
      start_time: @appointment.start_time,
      end_time: @appointment.end_time,
      busy: true
    }
  end
end
