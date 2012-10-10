class Permission < Struct.new(:user)
  def allow?(controller, action)
    Rails.logger.debug { "Permission's being checked for #{user}"}
    value = false
    value = true if user != nil && user.administrator == true
    value = true if controller == "mwod_posts" && action.in?(%w[index show])
    value = true if controller == "authentications" && action.in?(%w[create])
    value = true if controller == "devise/sessions" && action.in?(%w[destroy new create])    
    Rails.logger.debug {"Is permissioned to #{controller}##{action}? #{value}"}
    return value
    

  end
end