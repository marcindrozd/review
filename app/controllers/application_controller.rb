class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  helper_method :current_user, :authenticated?, :sign_in, :sign_out

  before_filter :authentication_check

  def index
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def authenticated?
    current_user.present?
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def authentication_check
    redirect_to auth_path unless authenticated?
  end
end
