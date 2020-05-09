class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                   foreign_key: "follower_id",
                   dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                   foreign_key: "followed_id",
                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes, dependent: :destroy
  has_many :comments
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i(google)
  validates :name,  presence: true, length: { maximum: 50 }
  validates :user_name,  presence: true, length: { maximum: 50 }

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  #コメントを削除する
  def delete_comment(post)
    comments.find_by(post_id: post.id).destroy
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                  OR user_id = :user_id", user_id: id)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
       notification = current_user.active_notifications.new(
       visited_id: id,
       action: 'follow'
       )
      notification.save if notification.valid?
     end
   end

  protected

    def self.find_for_google(auth)
      user = User.find_by(email: auth.info.email)
      unless user
        user = User.create(name:     auth.info.name,
                      user_name: auth.info.name,
                      provider: auth.provider,
                      uid:      auth.uid,
                      token:    auth.credentials.token,
                      email:    auth.info.email,
                      password: Devise.friendly_token[0,20],
                      meta:     auth.to_yaml)
      end
      user
    end
end
