class FavoritesController < ApplicationController
  def index
    @products = Product.all
    @users = User.all
  end
  def update
    favorite  = Favorite.where(product: Product.find(params[:product]), user: current_user)
    if favorite == []
      #Create favorite
      Favorite.create(product: Product.find(params[:product]), user: current_user)
      @favorite_exists = true
    else
      #Delete favorite 
      favorite.destroy_all
      @favorite_exists = false
    end
    respond_to do |format|
      format.html { }
      format.js { }
    end
  end
end
