class SchedulesController < ApplicationController
  respond_to :html

  before_action :set_schedule

  def edit
  end

  def update
    if @schedule
      @schedule.update(schedule_params)
    else
      Schedule.create(user_id: current_user.id, cron: params[:cron])
    end
    flash[:notice] = t(:schedule_update_notice)
    respond_to do |format|
      format.html { redirect_to(tasks_path) }
    end
  end

  private
    def set_schedule
      return redirect_to :root if current_user.nil?
      @schedule = Schedule.where(user_id: current_user.id).first || Schedule.new(user_id: current_user.id)
    end

    def schedule_params
      params.require(:schedule).permit(:cron)
    end
end
