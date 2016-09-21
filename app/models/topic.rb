class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :public

  has_many :posts, dependent: :destroy

  #scope :visible_to, -> (user) { user ? all : where(public: true) }
  scope :visible_to, -> (user) { user ? all : publicly_viewable }
  scope :privately_viewable, -> { where(public: false)}
  scope :publicly_viewable, -> { where(public: true) }
end
