class UsersController < ApplicationController

  # before_action :return_array_of_objects
  after_action :set_checkbox_value, only: [:update]

  def index
    @accounts = current_user.facebook.get_connections("me", "accounts")
    @pages = []
    @accounts.each do |account|
      if !Page.exists?(page_name: account['name'])
        @pages << current_user.pages.build(
          page_name: account['name'],
           fb_page_id: account['id'],
            page_access_token: account['access_token'],
           page_image: "https://graph.facebook.com/v2.12/#{account["id"]}/picture?access_token=#{account["access_token"]}&width=50&height=50",
         user_id: current_user.id )
       end
    end
  end

  def show

  end

  def edit

  end

  def update
    update_params = Hash.new
    i = 0
    user_params[:pages_attributes].each do |page|

     duplication = Page.where(fb_page_id: page[1]['fb_page_id']) #check the duplication of data in DB and store if not present
     unless duplication.present?
      if page[1][:checkbox_value].to_i != 0
        update_params.merge!("#{i}" => page[1].to_h)
        i += 1
      end
     end
    end

    new_params = user_params.except(:pages_attributes)
    new_params.merge!("pages_attributes" => update_params)
    if current_user.update!(new_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to pages_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :phone_number, :image, :first_name, :email, :last_name,
       pages_attributes: [:id, :page_name, :fb_page_id, :page_image, :page_access_token, :checkbox_value, :user_id])
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def return_array_of_object
    @accounts = current_user.facebook.get_connections("me", "accounts")
    objects_array = []
    @accounts.each do |account|
      objects_array << account
    end
  end

  def set_checkbox_value
    @pages = current_user.pages.all
    @pages.each do |page|
      page.update_attribute(:checkbox_value, false)
    end
  end

end
