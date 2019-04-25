task :fb_post => :environment do
  pagesposts = Pagespost.where("scheduled_published_time between #{Time.current- 1*60 and Time.current+1*60 } and published_status == false")
  pagesposts.each do |pagespost|
    if pagespost.present?
      retured_post_id = PostDelayJob.perform_now(pagesposts.page, pagesposts.post)
      pagespost = current_user.pagesposts.where(page_id: pagesposts.page.id, post_id: pagesposts.post.id)
      pagespost.update(fb_post_id: retured_post_id["id"], published_status: true)

    end
  end
end