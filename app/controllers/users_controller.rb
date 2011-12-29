class UsersController < Devise::RegistrationsController
  #respond_to :html, :json

  def new
    puts 'gid!!' unless params[:gid].nil?
  end

  def edit
    render("edit", :layout => "info_window")
  end

  def update
    if resource.update_with_password(params[resource_name])
      sign_in(resource_name, resource, :bypass => true)
      flash[:notice] = "Profile updated!"
      redirect_to(:controller => "info_window", :action => "index", :map_object_id => params[:map_object_id])
    else
      clean_up_passwords(resource)
      render(:json => {"errors" => resource.errors}, :status => 500)
    end
  end

  def create
    build_resource
    if resource.save
      sign_in resource
      render(:json => resource)
    else
      clean_up_passwords(resource)
      render(:json => {"errors" => resource.errors}, :status => 500)
    end
  end
end
