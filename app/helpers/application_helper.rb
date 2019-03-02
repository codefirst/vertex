module ApplicationHelper
  def user_omniauth_authorize_path
    method = "user_#{DotenvConfig.omniauth_provider}_omniauth_authorize_path".to_sym
    self.respond_to?(method) ? self.send(method) : ''
  end
end
