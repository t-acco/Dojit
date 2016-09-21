class Comment < ActiveRecord::Base
  
  attr_accessible :body, :post, :user, :user_id

  belongs_to :post
  belongs_to :user

  validates :body, length: { minimum: 5 }, presence: true
  validates :post, presence: true
  validates :user, presence: true

  after_create :send_favorite_emails 

  private

  def send_favorite_emails
    post.favorites.each do |favorite|
      if should_receive_update_for? favorite
        FavoriteMailer.new_comment(favorite.user, self.post, self).deliver
      end
    end
  end

  def should_receive_update_for?(favorite)
    user_id != favorite.user.id && favorite.user.email_favorites?
  end
end
