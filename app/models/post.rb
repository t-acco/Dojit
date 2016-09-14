class Post < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  attr_accessible :body, :title

  has_many :comments
end
