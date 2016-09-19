class Comment < ActiveRecord::Base
  
  attr_accessible :body, :post, :user

  belongs_to :post
  belongs_to :user

  validates :body, length: { minimum: 5 }, presence: true
  validates :post, presence: true
  validates :user, presence: true
end
