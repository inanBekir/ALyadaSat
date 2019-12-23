class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end
  def update
    favorite  = Favorite.where(product: Product.find(params[:product]), user: current_user)
    if favorite == []
      #Create favorite
      Favorite.create(product: Product.find(params[:product]), user: current_user)
      @favorite_exists = true
      @counter=current_user.pfavoritescount+1
      current_user.update_attribute(:pfavoritescount, current_user.pfavoritescount = @counter)
    else
      #Delete favorite 
      favorite.destroy_all
      @favorite_exists = false
      @counter=current_user.pfavoritescount-1
      current_user.update_attribute(:pfavoritescount, current_user.pfavoritescount = @counter)
    end
    respond_to do |format|
      format.html { }
      format.js { }
    end
  end
end
