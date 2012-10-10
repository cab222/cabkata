class Permission < Struct.new(:user)
  def allow?(controller, action)
    Rails.logger.debug {"Checking permission for:#{controller}##{action}"}
    value = false
    # if user
    #   value = true if user.admin?
    # end
    # if controller == "mwod_posts" && action.in?(%w[index show])
    #   value = true
    # elsif controller == "authentications" && action.in?(%w[create])
    #   value = true
    # elsif controller == "users" && action.in?(%w[edit create])
    #   value = true      
    # end
    # Rails.logger.debug {"Is permissioned to #{controller}##{action}? #{value}"}
    return value
  end
end