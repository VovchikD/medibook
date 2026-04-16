# frozen_string_literal: true

class AppointmentsController < BaseController
  def index
    render inertia: 'appointments/Index', props: {
      appointments: appointments.map { |a|
        AppointmentPresenter.new(a).as_json
      },
      doctors: doctors.map { |d| { id: d.id, fullname: d.fullname }
      }
    }
  end

  def create
    appointment = Appointment.new(appointment_params)
    appointment.patient = current_account

    if appointment.save
      render json: appointment
    else
      render json: { errors: appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    appointment = set_appointment

    if appointment.update(appointment_params)
      render json: appointment
    else
      render json: { errors: appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    appointment = set_appointment
    appointment.destroy!

    head :ok
  end

  private

  def appointments
    current_account.patient_appointments.includes(:doctor)
  end

  def doctors
    Account.where(role: :doctor)
  end

  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :notes, :status, :doctor_id)
  end

  def set_appointment
    @set_appointment ||= current_account.patient_appointments.find(params[:id])
  end
end
