class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  # GET /products
  # GET /products.json


  def index
    @products = Product.all
    @products = @products.gender(params[:gender]) if params[:gender].present?
  end

  # GET /products/1
  # GET /products/1.json
  # def show

  def options_for_klass(klass)
    options = ::PiggybakVariants::OptionConfiguration.where(klass: klass).includes(:option).collect { |oc| oc.option }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description)
    end
end
