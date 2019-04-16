class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, through: :listings

  def city_openings(check_in, check_out)
    openings = []
    listings.each do |l|
      available = true
      l.reservations.each do |r|
        booking_days = r.checkin..r.checkout
        if booking_days.include?(check_in.to_date) || booking_days.include?(check_out.to_date)
          available = false
        end
      end
      openings << l if available
    end
    openings
  end

  def self.highest_ratio_res_to_listings
    ratios = []
    c_ratios = {}
    City.all.each do |c|
      listings_count = c.listings.length
      reservations_count = c.reservations.length
      if listings_count > 0
        ratio =  reservations_count / listings_count
        ratios << ratio
        c_ratios[ratio] = c
      end
    end
    c_ratios[ratios.max]
  end
end
