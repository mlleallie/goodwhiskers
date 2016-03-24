class HomeController < ApplicationController
  def index
    @latest_three_reviews = Review.last(3)
    @product = Product.all
    @category = Category.all
  end
end
