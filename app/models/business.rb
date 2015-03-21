class Business < ActiveRecord::Base
  has_many :users, dependent: :destroy
  before_save { email.downcase! }

  # Validations
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@([a-z\d\-]+\.)+[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validates :city, :zip, :phone_number, :website, presence: true

end
