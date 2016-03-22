class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  ratyrate_rateable "rating"
end
