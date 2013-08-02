class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def fitbit
    @user = User.find_for_fitbit_oauth(request.env["omniauth.auth"], current_user)

    unless @user.persisted?
      @user.save
    end

    sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, :kind => "Fitbit") if is_navigational_format?
  end

  protected
  def after_omniauth_failure_path_for resource
    root_path
  end
end
