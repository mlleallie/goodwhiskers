class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @product = Product.find(params[:product_id])
  end

  def create
    @review = Review.new(review_params)
    @product = Product.find(params[:product_id])
    @review.product = @product
    @review.save
    redirect_to product_path(@product)
    # raise
  end

# def destroy - would be nice
#   @review = Review.find(params[:id])
#   raise
#   @review.destroy
# end
  # def show
  #   @review = Review.find(params[:review_id])

  private
  def review_params
    params.require(:review).permit(:title, :comment, :rating, :user_id, :product_id)
  end

end
