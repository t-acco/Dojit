class Comment < ActiveRecord::Base
  
  attr_accessible :body, :post

  belongs_to :post
end
