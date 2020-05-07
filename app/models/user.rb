class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i(google)
  validates :name,  presence: true, length: { maximum: 50 }
  validates :user_name,  presence: true, length: { maximum: 50 }

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
