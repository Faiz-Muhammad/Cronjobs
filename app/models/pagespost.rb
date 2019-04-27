class Pagespost < ApplicationRecord
  require 'rest-client'
  belongs_to :user
  belongs_to :page
  belongs_to :post


  def self.post_status(page, post)
    # <-------------- STATUS POST REQUEST ---------->
    fb_page_id = page.fb_page_id
    page_access_token = page.page_access_token
    message = post.description

    uri = URI.parse("https://graph.facebook.com/#{fb_page_id}/feed")
    uri.query = URI.encode_www_form(
        'access_token' => page_access_token,
        'message' => message
    )
    request_uri= uri.to_s

    res = RestClient::Request.execute(method: :post,
                                      url: request_uri,
                                      timeout: 10)
    retured_post_id = JSON.parse(res)
    return retured_post_id
  end


  def self.post_link(page, post)
    # <-------------- LINK POST REQUEST ---------->
    fb_page_id = page.fb_page_id
    page_access_token = page.page_access_token
    message = post.description
    link = post.link

    uri = URI.parse("https://graph.facebook.com/#{fb_page_id}/feed")
    uri.query = URI.encode_www_form(
        'access_token' => page_access_token,
        'message' => message,
        'link' => link
    )
    request_uri= uri.to_s

    res = RestClient::Request.execute(method: :post,
                                      url: request_uri,
                                      timeout: 10)
    retured_post_id = JSON.parse(res)
    return retured_post_id
  end

  def self.post_pictures(page, post)
    # <-------------- PICTURES POST REQUEST ---------->
    if post.images.count == 1

      image_url = post.images.first.service_url
      fb_page_id = page.fb_page_id
      page_access_token = page.page_access_token
      caption = post.description

      uri = URI.parse("https://graph.facebook.com/#{fb_page_id}/photos")
      uri.query = URI.encode_www_form(
          'url' => image_url,
          'access_token' => page_access_token,
          'caption' => caption
      )
      request_uri= uri.to_s

      res = RestClient::Request.execute(method: :post,
                                        url: request_uri,
                                        timeout: 10)
      retured_post_id = JSON.parse(res)
      return retured_post_id
    else
      picture_ids = []
      pictures_url_string = ""
      fb_page_id = page.fb_page_id
      page_access_token = page.page_access_token
      caption = post.description
      post.images.each do |image|

        image_url = image.service_url
        uri = URI.parse("https://graph.facebook.com/#{fb_page_id}/photos")
        uri.query = URI.encode_www_form(
            'url' => image_url,
            'access_token' => page_access_token,
            'message' => caption,
            'published' => false
        )
        request_uri= uri.to_s
        res = RestClient::Request.execute(method: :post,
                                          url: request_uri,
                                          timeout: 10)
        retured_post_id = JSON.parse(res)
        picture_ids << retured_post_id["id"]

      end
      picture_ids.each_with_index do |id, index|
        pictures_url_string << "&attached_media[#{index}]={media_fbid:'#{id}'}"
      end
      res = RestClient::Request.execute(method: :post,
                                        url: "https://graph.facebook.com/#{page.fb_page_id}/feed?#{pictures_url_string}&message=#{caption}&access_token=#{page.page_access_token}",
                                        timeout: 10)
      retured_post_id = JSON.parse(res)
      return retured_post_id
    end
  end

  def self.post_video(page, post)
    # <-------------- VIDEO POST REQUEST ---------->
    page_graph = Koala::Facebook::API.new(page.page_access_token)
    res = page_graph.put_video(post.video.service_url, {description: "#{post.description}"}, page.fb_page_id)
    return res
  end

  def delete_post(page, post)
    # <--------------POST DELETE  REQUEST ---------->
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
