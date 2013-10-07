class User < ActiveRecord::Base
  has_one :cart
  has_many :orders

  has_secure_password validations: false
  validates :password, presence: true, on: :create, length: {minimum: 6}
  validates_confirmation_of :password
  validates_presence_of :name,:email, :phone, :zip_code, :country
  # validates_uniqueness_of :email, :case_sensitive => false

  def admin?
    self.role == "admin"
  end

end
