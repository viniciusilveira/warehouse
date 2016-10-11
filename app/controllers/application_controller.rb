class ApplicationController < ActionController::Base
  extend EnumerateIt

  protect_from_forgery with: :exception
end
