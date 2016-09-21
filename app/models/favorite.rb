class Favorite < ActiveRecord::Base
  attr_accessible :post, :user

  belongs_to :user
  belongs_to :post
end
