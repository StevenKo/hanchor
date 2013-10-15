class User < ActiveRecord::Base
  has_one :cart
  has_many :orders

  has_secure_password validations: false
  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates :password, on: :update, length: {minimum: 5}, allow_blank: true
  validates_confirmation_of :password
  validates_presence_of :name,:email, :phone, :zip_code, :country
  validates_uniqueness_of :email, :case_sensitive => false

  def admin?
    self.role == "admin"
  end

end
