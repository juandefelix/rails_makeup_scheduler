class Business < ActiveRecord::Base
  resourcify

  has_many :users, dependent: :destroy

  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }
  validates :city, :zip, :phone_number, :website, presence: true
  validates :email, presence: true,
                    format: { with: MsUtilities::VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
end
