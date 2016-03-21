class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :reviews
end
