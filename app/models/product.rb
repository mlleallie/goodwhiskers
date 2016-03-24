class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :reviews, dependent: :destroy

	  def self.search(search)
	  	where("name ILIKE ? OR description ILIKE ?", "%#{search}%", "%#{search}%")
	  end
end
