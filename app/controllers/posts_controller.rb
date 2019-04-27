class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @pages=[]
    params["page_ids"].each do |page|
      @pages << Page.find_by(id: page.to_i)
    end
    @post = current_user.posts.create(post_params)
    calculate_posting_time(params["post"]['start_time'], params["post"]['interval'], params["post"]['time_gap'], params["post"]['delete_time'], @post, @pages)


    flash[:success] = "Post has been created and will post on page according to time!"
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:start_time, :interval, :delete_time, :time_gap, :user_id, :video, :link, :description, images: [], page_ids: [])
  end



  def calculate_posting_time(start_time, interval, time_gap, delete_time, post, pages)
    scheduled_publish_time = Time.now
    delete_post_time = Time.now
    pagespost_params = Hash.new
    pages.each_with_index do |page, index|
      if index != 0
        scheduled_publish_time += (interval.to_i)*60
      end
      scheduled_publish_time += (start_time.to_i)*60 + (time_gap.to_i)*60

      unless delete_time.to_i == 0
        delete_post_time = scheduled_publish_time + (delete_time.to_i)*60
      else
        delete_post_time = 0
      end
      pagespost_params = {"page_id" => "#{page.id}", "post_id" => "#{post.id}",
                          "scheduled_published_time" => "#{scheduled_publish_time}", "delete_post_time" => "#{delete_post_time}"}
      @pagespost = current_user.pagesposts.create(pagespost_params)
    end
  end
end
