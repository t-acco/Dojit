class Post < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include Rails.application.routes.url_helpers
  extend Paginate
  attr_accessible :body, :title, :user, :topic, :image

  has_many :comments
  belongs_to :user
  belongs_to :topic
  mount_uploader :image, PostUploader

  default_scope { order('created_at DESC') }

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def image?
     image.length > 0
  end
end