class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
  
    def configure_permitted_parameters
      added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
      devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
    end

    def favorite_text
      @favorite = "<div class=alert alert-primary close role=alert>Ürün favorilere eklendi.</div>"
      @unFavorite = "<div class=alert alert-primary role=alert>Ürün favorilerden silindi.</div>"
      return @favorite_exists ? @favorite.html_safe : @unFavorite.html_safe
    end
    helper_method :favorite_text
end
