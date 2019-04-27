class PostDelayJob < ApplicationJob
  queue_as :default
  def perform(page,post)

    if post.link.present?
      Pagespost.post_link(page, post)
    elsif post.images.present?
      res =Pagespost.post_pictures(page, post)
    elsif post.video.attached?
      res = Pagespost.post_video(page, post)
    else
      res = Pagespost.post_status(page, post)
    end
  end
end
