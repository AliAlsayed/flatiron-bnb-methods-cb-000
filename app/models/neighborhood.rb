class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  def neighborhood_openings(check_in, check_out)
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
    Neighborhood.all.each do |n|
      listings_count = 0
      reservations_count = 0
      listings_count += n.listings.length
      n.listings.each do |l|
        reservations_count += l.reservations.length
      end
    end
  end

end
