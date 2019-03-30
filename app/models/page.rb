class Page < ApplicationRecord
  belongs_to :user
  has_many :pagesposts



  def facebook
    @facebook ||= Koala::Facebook::API.new(page_access_token)
  end
end
