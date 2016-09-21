class Post < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  attr_accessible :body, :title, :user, :topic, :image, :rank, :created_at

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  mount_uploader :image, PostUploader

  default_scope { order('rank DESC') }

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def image?
     image.length > 0
  end

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum :value
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
    new_rank = points + age_in_days

    update_attribute(:rank, new_rank)
  end

  def create_vote
    vote = votes.create(value: 1, user: user)
    vote.save
  end
end