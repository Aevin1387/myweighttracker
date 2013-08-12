class User < ActiveRecord::Base
  devise :omniauthable
  validates :provider, :uid, :full_name, :display_name, :oauth_token, :oauth_token_secret, presence: true

  has_many :measurements

  def self.new_with_session(params, section)
  end

  def self.find_for_fitbit_oauth(auth, signed_in_resource=nil)
    binding.pry
    User.where(provider:auth.provider, uid:auth.uid).
         first_or_create(full_name:auth.info.full_name,
                         display_name: auth.info.display_name,
                         oauth_token: auth.info.oauth_token,
                         oauth_token_secret: auth.info.oauth_token_secret)
  end
end
