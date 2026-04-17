# frozen_string_literal: true

class DoctorSchedulesController < BaseController
  include DefaultWorkingHours

  def show
    if doctor && doctor.schedules.any?
      render json: doctor.schedules.map { |s| DoctorSchedulePresenter.new(s).format_schedules }
    else
      render json: DEFAULT_WORKING_HOURS
    end
  end

  def bulk_update
    authorize current_account, :bulk_update?

    params[:schedules].each do |schedule|
      record = current_account.schedules.find_or_initialize_by(
        day_of_week: schedule[:day]
      )

      update_record!(record, schedule)
    end

    head :ok
  end

  private

  def doctor
    @doctor ||= Account.doctor.find_by(id: params[:id])
  end

  def update_record!(record, schedule)
    record.update!(
      start_time: schedule[:enabled] ? schedule[:start] : nil,
      end_time: schedule[:enabled] ? schedule[:end] : nil,
    )
  end
end
