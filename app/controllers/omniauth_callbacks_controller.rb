class OmniauthCallbacksController < ApplicationController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if !@user.nil?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      flash[:notice] = "Bienvenido al sistema"
    else
      flash[:notice] = "Error de autenticacion"
      failure
    end
  end

  def failure
    redirect_to root_path
  end

end
