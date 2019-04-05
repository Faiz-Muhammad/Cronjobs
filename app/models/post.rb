class Post < ApplicationRecord
  has_many :pagesposts
  has_many :pages, through: :pagespost
  belongs_to :user
  has_many_attached :images
  has_one_attached :video

  attr_accessor :start_time
  attr_accessor :interval
  attr_accessor :time_gap
  attr_accessor :delete_time

end
