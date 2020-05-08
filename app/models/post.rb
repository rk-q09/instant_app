class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :iine_users, through: :likes, source: :user
  has_many :comments
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :caption, presence: true

  #いいねする
  def iine(user)
    likes.create(user_id: user.id)
  end

  #いいねを解除する
  def not_iine(user)
    likes.find_by(user_id: user.id).destroy
  end

  def iine?(user)
    iine_users.include?(user)
  end
end
