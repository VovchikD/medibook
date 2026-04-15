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
end
