class PostDelayJob < ApplicationJob
  queue_as :default

  def perform(page,post)
    if @post.link.present?
      Pagespost.post_link(page, post)
    elsif @post.images.present?
      Pagespost.post_pictures(page, post)
    else
      Pagespost.post_status(page, post)
    end
  end
end

