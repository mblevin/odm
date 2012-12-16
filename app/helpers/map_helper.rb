module MapHelper
  def delete_link(event)
    if session[:username] == params[:user_id] || (!@authenticated_user.nil? && @authenticated_user.user_type == "admin")
      link_to "Delete", user_map_event_path(@user, @map, event), :method => :delete
    end
  end
end