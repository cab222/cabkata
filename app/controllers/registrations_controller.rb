class RegistrationsController < Devise::RegistrationsController  
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  def edit
    @authentications = current_user.authentications if current_user
    logger.debug { "# of authentications #{@authentications.length}, for #{current_user.email}" }
    super
  end
  
  def index
    @users = User.all
  end
  
  def update
    @user = User.find(current_user.id)
    email_changed = @user.email != params[:user][:email]
    password_changed = params[:user][:password] != nil && !params[:user][:password].empty?
    logger.debug "Updating #{@user.email} email changed? #{email_changed}, password changed? #{password_changed}"
    
    successfully_updated = if email_changed or password_changed
      logger.debug "Updating user with password"
      @user.update_with_password(params[:user])
    else
      logger.debug "Updating user without password"
      params[:user].delete :password     
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "edit"
    end
  end
  
    
  private
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
  

end