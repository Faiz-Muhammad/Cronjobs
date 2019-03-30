class PagesController < ApplicationController
  def index

  end

  def show

  end

  def new
    @page = current_user.pages.find(2)
  end

  def create
    if params.has_key?("page")
      current_user.pages.create(pages_params(params["page"]))
    else
      params["pages"].each do |page|
        current_user.pages.create(pages_params(page))
      end
    end
  end

  private
  def pages_params(my_params)
    my_params.permit(:page_name, :fb_page_id, :page_access_token, :page_image)
  end

  # def pages_params
  #   params.require(:pages).permit(:page_name, :fb_page_id, :page_image, :page_access_token)
  # end

end
