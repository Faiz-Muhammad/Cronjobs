task :fb_post => :environment do
  pagesposts = Pagespost.where("published_status = ? AND scheduled_published_time BETWEEN ? AND ?", false, (Time.current - 5*60), (Time.current + 5*60))
  pagesposts.each do |pagespost|
    if pagespost.present?
      retured_post_id = PostDelayJob.perform_now(pagespost.page, pagespost.post)
      pagespost.update(fb_post_id: retured_post_id["id"], published_status: true)
    end
  end
end