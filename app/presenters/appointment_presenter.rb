# frozen_string_literal: true

class AppointmentPresenter
  FIELDS = %i[
    id
    doctor_name
    patient_name
    start_time
    end_time
    notes
    range_consultation
    doctor_id
  ].freeze

  def initialize(appointment)
    @appointment = appointment
  end

  def id
    @appointment.id
  end

  def doctor_name
    @appointment.doctor.fullname
  end

  def patient_name
    "#{@appointment.patient.fullname} - Consultation"
  end

  def start_time
    @appointment.start_time
  end

  def end_time
    @appointment.end_time
  end

  def notes
    @appointment.notes
  end

  def range_consultation
    "#{@appointment.start_time.strftime('%d.%m')}: #{@appointment.start_time.strftime('%H:%M')} - #{@appointment.end_time.strftime('%H:%M')}"
  end

  def doctor_id
    @appointment.doctor_id
  end

  def as_json(*fields)
    (fields.presence || FIELDS).index_with { |field| public_send(field) }
  end
end
