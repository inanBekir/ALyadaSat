class User < ApplicationRecord
  has_many :products
  has_many :favorites
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
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
end
