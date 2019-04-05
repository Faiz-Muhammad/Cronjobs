class Page < ApplicationRecord
  belongs_to :user
  has_many :pagesposts
  has_many :posts, through: :pagespost 



  def facebook
    @facebook ||= Koala::Facebook::API.new(page_access_token)
  end
end
