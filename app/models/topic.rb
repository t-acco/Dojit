class Topic < ActiveRecord::Base
  extend Paginate
  include Rails.application.routes.url_helpers

  attr_accessible :description, :name, :public

  has_many :posts
end
