class Business < ActiveRecord::Base
  resourcify

  has_many :users, dependent: :destroy

  before_save { email.downcase! }

  VALID_EMAIL_REGEX = MsUtilities::VALID_EMAIL_REGEX

  validates :name, presence: true, length: { maximum: 50 }
  validates :city, :zip, :phone_number, :website, presence: true
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
end
