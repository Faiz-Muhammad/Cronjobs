task :fb_post => :environment do
  pagesposts = Pagespost.where("published_status = ? AND scheduled_published_time BETWEEN ? AND ?", false, (Time.current - 1*60), (Time.current + 1*60))
  pagesposts.each do |pagespost|
    if pagespost.present?
      retured_post_id = PostDelayJob.perform_now(pagespost.page, pagespost.post)
      pagespost.update(fb_post_id: retured_post_id["id"], published_status: true)
    end
  end
end


task :delete_posts => :environment do
  pagesposts = Pagespost.where("deleted_status = ? AND published_status = ? AND delete_post_time BETWEEN ? AND ?", false, true, (Time.current - 1*60), (Time.current + 1*60))
  pagesposts.each do |pagespost|
    if pagespost.present?
      delete_status = Pagespost.delete_post(pagespost.page, pagespost.post)
      if delete_status['success']
        pagespost.update(deleted_status: true)
      end
    end
  end
end
