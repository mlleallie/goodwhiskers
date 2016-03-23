class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def edit
    @reviews = Review.find(params[:id])
    @user = @reviews[:user_id]
    # if current user = review user id = true

  end

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
  end

  # def show
  #   @review = Review.find(params[:review_id])

  private
  def review_params
    params.require(:review).permit(:title, :comment, :rating, :user_id, :product_id)
  end

end
