class HomeController < ApplicationController
  def index
    redirect_to materials_path if user_signed_in?
  end
end
