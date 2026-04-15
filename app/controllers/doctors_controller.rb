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

    render json: appointments.map { |a| AppointmentPresenter.new(a).as_json }
  end
end
