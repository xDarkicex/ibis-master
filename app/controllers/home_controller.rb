class HomeController < ApplicationController
  def index
    # @products = Product.all
    @slides = Slide.all
    @recent = Product.last(5).reverse
  end
end
