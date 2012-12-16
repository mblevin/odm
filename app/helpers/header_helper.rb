module HeaderHelper
  def member_or_non_member
    if @authenticated_user
      render :partial => 'shared/member_options'
    else
      render :partial => 'shared/non_member_options'
    end
  end

  def member_edit_option
    if params[:controller] == "events" && params[:action] == "new"
      link_to "Edit \"#{@map.title}\"", edit_user_map_path(params[:user_id], params[:map_id])
    elsif params[:controller] == "maps" && params[:action] == "show"
      link_to "Add Events", new_user_map_event_path(@user, @map)
    elsif params[:controller] == "users" && params[:action] == "show"
      link_to "Edit Your Account", edit_user_path(@user)
    else
      link_to "View Your Maps", user_path(session[:username])
    end
  end

  def show_hide_link
    if params[:controller] == "maps" && params[:action] == "show"
      link_to "Hide Event Details", '#'
    end
  end
end