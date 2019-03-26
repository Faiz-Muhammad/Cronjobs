class Post < ApplicationRecord
  has_many :pagesposts
  belongs_to :user
  has_many_attached :images
  has_many_attached :videos
  has_one_attached :file
end
