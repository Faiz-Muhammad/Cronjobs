class Pagespost < ApplicationRecord
  require 'rest-client'
  belongs_to :user
  belongs_to :page
  belongs_to :post



  def self.post_status(page, post)
    # <-------------- STATUS POST REQUEST ---------->
    res = RestClient::Request.execute(method: :post,
                                      url: "https://graph.facebook.com/#{page.fb_page_id}/feed?message=#{post.description}&access_token=#{page.page_access_token}",
                                      timeout: 10
    )
    retured_post_id = JSON.parse(res)
    return retured_post_id
  end


  def self.post_link(page, post)
    # <-------------- LINK POST REQUEST ---------->
    response = RestClient::Request.execute(method: :post,
                                           url: "https://graph.facebook.com/#{page.fb_page_id}/feed?message=#{post.description}&link=#{post.link}&access_token=#{page.page_access_token}",
                                           timeout: 10)
    retured_post_id = JSON.parse(response)
   return retured_post_id
    # @pagespost = current_user.pagesposts.where(page_id: page.id, post_id: post.id)
    # @pagespost.update_attribute(:fb_post_id, retured_post_id["id"])
  end

  def self.post_pictures(page, post)
    # <-------------- PICTURES POST REQUEST ---------->
    if post.images.count == 1
      binding.pry
      response = RestClient::Request.execute(method: :post,
                                             url: "https://graph.facebook.com/#{page.fb_page_id}/photos?url=#{polymorphic_url(post.images.first)}&caption=#{post.description}&access_token=#{page.page_access_token}",
                                             timeout: 10)
      retured_post_id = JSON.parse(response)
      return retured_post_id

      # @pagespost = current_user.pagesposts.where(page_id: page.id, post_id: post.id)
      # @pagespost.update_attribute(:fb_post_id, retured_post_id["post_id"])
    else
      picture_ids = []
      pictures_url_string = ""
      post.images.each do |image|
        response = RestClient::Request.execute(method: :post,
                                                 url: "https://graph.facebook.com/#{page.fb_page_id}/photos?url=#{polymorphic_url(post.images.first)}&message=#{post.description}&published=false&access_token=#{page.page_access_token}",
                                               timeout: 10)
        retured_post_id = JSON.parse(response)
        picture_ids << retured_post_id["id"]
      end
      picture_ids.each_with_index do |id, index|
        pictures_url_string << "&[#attached_media{index}]={media_fbid:'#{id}'}"
      end
      response = RestClient::Request.execute(method: :post,
                                             url: "https://graph.facebook.com/#{page.fb_page_id}/feed?#{pictures_url_string}&message=#{msg}&access_token=#{page.page_access_token}",
                                             timeout: 10)
      retured_post_id = JSON.parse(response)
      @pagespost = current_user.pagesposts.where(page_id: page.id, post_id: post.id)
      @pagespost.update_attribute(:fb_post_id, retured_post_id["id"])
    end
  end

  def post_video(page, post)  
    page_graph = Koala::Facebook::API.new(page.page_access_token)
    response = page_graph.put_video(url_for("001 Introduction.mp4"), {description: "#{post.description}"}, page.fb_page_id)
    @pagespost = current_user.pagesposts.where(page_id: page.id, post_id: post.id)
    @pagespost.update_attribute(:fb_post_id, retured_post_id["id"])
  end

  def delete_post(page, post)
    response = RestClient::Request.execute(method: :delete,
                                           url: "https://graph.facebook.com/#{page.fb_page_id}/#{post.pagesposts.fb_post_id}?&access_token=#{page.page_access_token}",
                                           timeout: 10)
    if response["success"]
      flash[:success] = "Post has been deleted successfully!"
    else
      flash[:danger] = "There is something wrong with deletion of this post!"
    end
  end

end
