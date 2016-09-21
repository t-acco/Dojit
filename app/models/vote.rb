class Vote < ActiveRecord::Base
  attr_accessible :post, :user, :value

  belongs_to :user
  belongs_to :post

  after_save :update_post

  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }
  #validates :user, presence: true
  #validates :post, presence: true

  def up_vote?
    value == 1
  end

  def down_vote?
    value == -1
  end

  private

  def update_post
    post.update_rank
  end
end
