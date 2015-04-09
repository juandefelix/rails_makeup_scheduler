class Business < ActiveRecord::Base
  resourcify

  has_many :users, dependent: :destroy

  before_save { email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@([a-z\d\-]+\.)+[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :city, :zip, :phone_number, :website, presence: true
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
end
