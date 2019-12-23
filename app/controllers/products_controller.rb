class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [ :show, :index]
  # GET /products
  # GET /products.json
  def index
    @products = Product.order('updated_at DESC')
    if user_signed_in?
    @users = User.where.not(id: current_user.id)
    @favorite_exists = Favorite.where(product: @product, user: current_user) == [] ? false : true
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  def sellingnow
    @users = User.all
    @product = Product.where(isonsell: false , user_id: current_user)
  end

  def isonsell
    @users = User.all
    @product = Product.where(isonsell: true , user_id: current_user)
  end

  def reactive
    @product = Product.find(params[:id])
    @product.update_attribute(:isonsell, @product.isonsell = true)
    @counter=current_user.psellingcount+1
    @counter2=current_user.psoldedcount-1
    current_user.update_attribute(:psellingcount, current_user.psellingcount = @counter )
    current_user.update_attribute(:psoldedcount, current_user.psoldedcount = @counter2 )  
    respond_to do |format|
      if @product.save
        format.html { redirect_to sellingnow_product_path, notice: 'Ürün tekrar aktif edildi' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def markassell
      @product = Product.find(params[:id])
      @product.update_attribute(:isonsell, @product.isonsell = false)
      @counter=current_user.psoldedcount+1
      @counter2=current_user.psellingcount-1
      current_user.update_attribute(:psoldedcount, current_user.psoldedcount = @counter)
      current_user.update_attribute(:psellingcount, current_user.psellingcount = @counter2)
      respond_to do |format|
        if @product.save
          format.html { redirect_to isonsell_product_path, notice: 'Ürün satıldı olarak değiştirildi.' }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
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
    @counter=current_user.psellingcount+1
    current_user.update_attribute(:psellingcount, current_user.psellingcount = @counter)
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
        format.html { redirect_to @product, notice: 'Ürün güncellendi.' }
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
    if current_user.psellingcount > 0
      @counter=current_user.psellingcount-1
      current_user.update_attribute(:psellingcount, current_user.psellingcount = @counter)
    end
    if current_user.psoldedcount > 0
      @counter2=current_user.psoldedcount-1
      current_user.update_attribute(:psoldedcount, current_user.psoldedcount = @counter2)
    end
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
      params.require(:product).permit(:pname, :pdescription, :pprice, :plocation, :photo,:isonsell, :user_id)
    end
end
