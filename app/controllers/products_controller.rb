class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
      @products = Product.all

       if params[:search]
      @products = Product.search(params[:search]).order("created_at DESC")

    else
      @products = Product.all.order('created_at DESC')
    end

  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
    @user = @product.user_id
    #start for future review delete functionality
    # @review = @reviews.find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new

  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @user = @product.user_id
  end

  def create
    @product = Product.new(product_params)
    response = Cloudinary::Uploader.upload(params["product"]["image"], :transformation => [
      {:width => 500, :height => 500, :crop => :limit},
     ],
      :eager => [
                  {:width => 75, :height => 75,
                  :crop => :thumb, :format => 'png'},
        ])
    @product.image = response["url"]
    @product.thumb = response["eager"][0]["url"]
    # if params[:image_id].present?
  # preloaded = Cloudinary::PreloadedFile.new(params[:image_id])
  # raise "Invalid upload signature" if !preloaded.valid?
  # @product.image_id = preloaded.identifier

  respond_to do |format|
    if @product.save
      format.html { redirect_to @product, notice: 'Product was successfully created.' }
      format.json { render :show, status: :created, location: @product }
    else
      format.html { render :new }
      format.json { render json: @product.errors, status: :unprocessable_entity }
    end
  end
end
  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
     if params["product"]["image"].present?
    response = Cloudinary::Uploader.upload(params["product"]["image"], :transformation => [
      {:width => 500, :height => 500, :crop => :limit},
     ],
      :eager => [
                  {:width => 75, :height => 75,
                  :crop => :thumb, :format => 'png'},
        ])
      @product.image = response["url"]
      @product.thumb = response["eager"][0]["url"]
      
    else
      @product.image = @product.image
      @product.thumb = @product.thumb
    end

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :mfg, :description, :url, :user_id, :category_id, :file)
    end
end
