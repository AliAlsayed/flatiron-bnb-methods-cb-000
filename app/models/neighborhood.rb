class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  def neighborhood_openings(check_in, check_out)
    openings = []
    listings.each do |l|
      available = true
      l.reservations do |r|
        booking_days = r.checkin..r.checkout
        if booking_days.include?(check_in) || if booking_days.include?(check_out)
          available = false
          break
        end
      end
      openings << l if available
    end
    openings
  end
  
end
