class ApplicationController < ActionController::Base
  before_action :init_variables?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def init_variables?
    @nav = Page.all
    @meta = SearchEngineOptimization.all
  end

end
