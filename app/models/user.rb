class User < ActiveRecord::Base
  has_one :cart
  has_many :orders

  has_secure_password validations: false
  validates :password, presence: true, on: :create, length: {minimum: 6}

  def admin?
    self.role == "admin"
  end

end
