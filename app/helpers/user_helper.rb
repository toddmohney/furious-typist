module UserHelper

  def show_role(user)
    user.is_admin? ? "admin" : ""
  end

end
