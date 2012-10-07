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
    
  private
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
  

end