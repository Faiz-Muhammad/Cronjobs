class PostsController < ApplicationController

  def index

  end

  def new
    @post = Post.new
  end

  def create
    @pages=[]
    @pages << Page.first
     # link.each_with_index do |l,index|
       post_new_params = Hash.new
       post_new_params.merge!({"link" => "#{params["post"]['link']}", "description" => "#{params["post"]['description']}"})
      @post = current_user.posts.create!(post_params)
      calculate_posting_time(params["post"]['start_time'],params["post"]['interval'],params["post"]['time_gap'],params["post"]['delete_time'],@post, @pages)
    # end
    # @post = Post.new(post_params)
    # @post.user = current_user
    # @post.save
    # flash[:success] = "Post has been created!"
    # redirect_to pages_path
  end


  private
  def post_params
    params.require(:post).permit(:start_time, :interval, :delete_time, :time_gap, :user_id, :video, :link, :description, images: [], page_ids: [])
  end

  def calculate_posting_time(start_time, interval, time_gap, delete_time, post, pages)
    scheduled_publish_time = 0
    pagespost_params = Hash.new
    pages.each_with_index do |page,index|
      if index != 0
        scheduled_publish_time += interval.to_i
      end
      scheduled_publish_time += start_time.to_i + time_gap.to_i
      if !delete_time.nil?
        delete_post_time = scheduled_publish_time + delete_time.to_i
      else
        delete_post_time = 0
      end
      pagespost_params = {"page_id" => "#{page.id}", "post_id" => "#{post.id}",
         "scheduled_published_time" => "#{scheduled_publish_time}", "delete_post_time" => "#{delete_post_time}"}
      @pagespost = current_user.pagesposts.create!(pagespost_params)
    end
  end
end
