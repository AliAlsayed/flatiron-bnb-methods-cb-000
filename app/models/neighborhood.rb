class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  def neighborhood_openings(check_in, check_out)
    listings.merge(Listing.available(check_in, check_out))
    # openings = []
    # listings.each do |l|
    #   available = true
    #   l.reservations.each do |r|
    #     booking_days = r.checkin..r.checkout
    #     if booking_days.include?(check_in.to_date) || booking_days.include?(check_out.to_date)
    #       available = false
    #     end
    #   end
    #   openings << l if available
    # end
    # openings
  end
end
