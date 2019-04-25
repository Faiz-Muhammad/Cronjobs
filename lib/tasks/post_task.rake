task :fb_post => :environment do
  pagesposts = Pagespost.where("scheduled_published_time between #{Time.current- 1*60 and Time.current+1*60 } and published_status == false")
  pagesposts.each do |pagespost|
    if pagespost.present?
      if @post.link.present?
        Pagespost.post_link(pagespost.page, pagespost.post)
      elsif @post.images.present?
        Pagespost.post_pictures(pagespost.page, pagespost.post)
      else
        Pagespost.post_status(pagespost.page, pagespost.post)
      end
    end
  end
end