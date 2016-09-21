class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
   attr_accessible :email, :password, :password_confirmation, :name, :role, :avatar
   has_many :posts
   has_many :comments
   has_many :votes
   has_many :favorites
   mount_uploader :avatar, AvatarUploader

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  def favorited(post)
    favorites.where(post_id: post.id).first
  end

  def voted?(post)
    votes.where(post_id: post.id).first
  end
end
