class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  acts_as_token_authentication_handler_for User, if: lambda { |controller| controller.request.format.json? }

  def verify_authenticity_token
    super unless has_user_token?
  end

  private
  def has_user_token?
    not params[:user_token].blank?
  end
end
