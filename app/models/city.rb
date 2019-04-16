class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(check_in, check_out)
    listings.select do |listing|
      listing.reservations.last#.checkout < check_in.to_date
    end
  end

end
