class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_product, only: [:show, :edit, :update, :destroy, :buy]
  before_action :check_can_modify, only: [:edit, :update, :destroy]
  helper_method :can_modify?
  helper_method :can_buy?
  # GET /products
  # GET /products.json
  def index
    @products = if params[:term]
      Product.where('name LIKE ?', "%#{params[:term]}%")
    else
      Product.all
    end 
  end

  def your
    @products = Product.where(user: current_user)
  end

  def bought
    @products = Product.where(buyer: current_user)
  end
  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  def buy
    @product.buyer = current_user
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'CONGRATULATIONS YOU BUY A PRODUCT!!!' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { redirect_to products_url , notice: 'You cant do that' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user = current_user
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
      params.require(:product).permit(:name, :price)
    end

    def can_modify? product
        product.user == current_user
    end

    def check_can_modify
        redirect_to products_url, notice: 'You cant access this operation' unless can_modify?(@product)     
    end

    def can_buy? product
      if product.buyer.nil? && !current_user.nil?
        product.user != current_user
      else
        false
      end
    end
end
