class User < ApplicationRecord
  has_many :products
  has_many :favorites
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :confirmable, 
         :omniauthable, :omniauth_providers => [:facebook],:authentication_keys => {email: true, login: false}
         
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar, presence: true
  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  attr_writer :login

  def login
    @login || self.username || self.email
  end

  private
def create_remember_token
  self.remember_token = SecureRandom.urlsafe_base64
end
def self.new_with_session(params, session)
  super.tap do |user|
    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
      user.email = data["email"] if user.email.blank?
    end
  end
end

def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.username = auth.info.name   # assuming the user model has a name
    user.avatar_file_name = auth.info.image # assuming the user model has an image
    user.skip_confirmation!
  end
end
end
