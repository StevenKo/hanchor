class Country < ActiveRecord::Base
  has_many :shipping_costs
end
