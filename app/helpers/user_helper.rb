module UserHelper
  def show_user_maps
    if @user.maps.count > 0
      render 'maps'
    end
  end

  def edit_user_link
    if @authenticated_user == @user
      link_to "Edit Your Profile", edit_user_path(@user)
    end
  end

  def new_user_map_link
    if @authenticated_user == @user
      link_to "Add a New Map", new_user_map_path(@user)
    end
  end
end