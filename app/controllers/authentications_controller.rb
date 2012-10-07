class AuthenticationsController < ApplicationController
  def show
    @authentication = Authentication.find(params[:id])
  end

  def new
    @authentication = Authentication.new
  end

  def edit
    @authentication = Authentication.find(params[:id])
  end

  def update
    @authentication = Authentication.find(params[:id])
    if @authentication.update_attributes(params[:authentication])
      redirect_to @authentication, :notice  => "Successfully updated authentication."
    else
      render :action => 'edit'
    end
  end

  def index
    @authentications = Authentication.all
  end
  
  def create
    omniauth = request.env["omniauth.auth"]  
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])  
    logger.debug "authencticated #{authentication}"
    
    if authentication  
      logger.debug "authencticated #{authentication.user.email}"
      flash[:notice] = "Signed in successfully."  
      sign_in_and_redirect(:user, authentication.user)  
    elsif current_user  
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])  
      flash[:notice] = "Authentication successful."  
      redirect_to authentications_url  
    else  
      logger.debug {"creating a new user from omniauth info"}
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end      
  end
  
  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end    
end
