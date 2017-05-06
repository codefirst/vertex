class NotificationsController < ApplicationController

  before_action :set_notification_settings

  def edit
  end

  def update
    begin
      ActiveRecord::Base.transaction do
        @schedule.update!(cron: params[:notifications_scheudle])
        @notification.kind = params[:notifications_type]
        @notification.token = ''
        @notification.token = params[:notifications_line_token] if @notification.is_line?
        @notification.save!
      end
    rescue => e
      flash[:alert] = e.message
    else
      flash[:notice] = t(:notifications_update_notice)
    end
    redirect_to edit_notification_path
  end

  private
  def set_notification_settings
    return redirect_to :root if current_user.nil?
    @schedule = Schedule.where(user_id: current_user.id).first || Schedule.new(user_id: current_user.id)
    @notification = Notification.first_or_default(current_user)
  end
end
