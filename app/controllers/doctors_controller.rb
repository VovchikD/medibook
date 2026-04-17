# frozen_string_literal: true

class DoctorsController < BaseController
  def index
    render inertia: 'doctors/Index', props: {
      doctors: Account.where(role: :doctor)
    }
  end

  def show
    doctor = Account.find(params[:id])

    render inertia: 'doctors/Show', props: {
      doctor: doctor
    }
  end

  def appointments
    appointments = Appointment.where(doctor_id: params[:id])
                               .where(start_time: params[:start]..params[:end])

    render json: appointments.map { |a| present_appointment(a) }
  end

  private

  def present_appointment(appointment)
    if owns_appointment?(appointment)
      AppointmentPresenter.new(appointment).as_json
    else
      BusyAppointmentPresenter.new(appointment).as_json
    end
  end

  def owns_appointment?(appointment)
    appointment&.doctor == current_account ||
      appointment&.patient == current_account
  end
end
