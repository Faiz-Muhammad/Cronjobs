class Pagespost < ApplicationRecord
  belongs_to :user
  belongs_to :page
  belongs_to :post
end
