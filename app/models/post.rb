class Post < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  attr_accessible :body, :title, :user, :topic

  has_many :comments
  belongs_to :user
  belongs_to :topic

  default_scope { order('created_at DESC') }
end
