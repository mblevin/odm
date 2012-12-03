module ApplicationHelper
  #nav helpers
  def show_login_or_logout_link
    if @authenticated_user
      link_to "Logout", logout_path
    else
      link_to "Login", login_path
    end
  end
  def logo_link
    if @authenticated_user
      link_to "zODM", dashboard_path
    else
      link_to "zODM", root_path
    end
  end
end
