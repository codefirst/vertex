class LineAccessTokensController < ApplicationController
  respond_to :html

  before_action :set_line_access_token

  def edit
  end

  def update
    if @line_access_token
      @line_access_token.update(line_access_token_params)
    else
      LineAccessToken.create(user_id: current_user.id, token: params[:token])
    end
    flash[:notice] = t(:line_access_token_update_notice)
    respond_to do |format|
      format.html { redirect_to(tasks_path) }
    end
  end

  private
    def set_line_access_token
      return redirect_to :root if current_user.nil?
      @line_access_token = LineAccessToken.where(user_id: current_user.id).first || LineAccessToken.new(user_id: current_user.id)
    end

    def line_access_token_params
      params.require(:line_access_token).permit(:token)
    end
end
