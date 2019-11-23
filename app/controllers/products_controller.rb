class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [ :show, :index]
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    if user_signed_in?
    @users = User.where.not(id: current_user.id)
    @favorite_exists = Favorite.where(product: @product, user: current_user) == [] ? false : true
    end

  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  def isonsell
    @users = User.all
    @product = Product.where(isonsell: true , user_id: current_user)
  
   
  end
  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    attributes = product_params.merge(user_id: current_user.id)
    @product = Product.new(attributes)

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
      params.require(:product).permit(:pname, :pdescription, :pprice, :pimage, :plocation, :photo,:isonsell, :user_id)
    end
end
