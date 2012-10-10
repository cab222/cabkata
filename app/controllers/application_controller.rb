class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize  
  delegate :allow?, to: :current_permission
  helper_method :allow?
  
  def current_permission
    if @current_permission == nil
      @current_permission = Permission.new(current_user)
    end
    
    logger.debug "User associated with permission: #{@current_permission[:user]}"
    
    if @current_permission != nil && @current_permission[:user] == nil && current_user != nil
      logger.debug "Redefining permission with #{current_user}"
      @current_permission = Permission.new(current_user)
    end
    
    if @current_permission != nil && @current_permission[:user] != nil && current_user == nil
      logger.debug "Redefining permission with #{current_user}"
      @current_permission = Permission.new(current_user)
    end
    
    @current_permission  
  end
  
  def authorize
    controller = params[:controller]
    action = params[:action]
    logger.debug "Calling authorize: #{controller}##{action}"
    if !current_permission.allow?(controller, action)
      logger.debug "Permission denied"
      redirect_to root_url, alert: "Not authorized."
    end
  end  
end
