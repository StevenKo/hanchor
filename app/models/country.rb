class Country < ActiveRecord::Base
  has_many :shipping_costs

  def self.generate_country_array
    str_array = []
    all.each do |country|
      str_array << [country.name, country.id]
    end
    str_array
  end
end
