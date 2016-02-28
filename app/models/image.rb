class Image < ActiveRecord::Base
  has_attached_file :asset,
    :styles => {
      :thumb => "50x50#",
      :medium => "200x200", 
      :large => "400x400"}
  validates_attachment_content_type :asset, :content_type => /\Aimage\/.*\Z/
  # add a delete_<asset_name> method:
  # attr_accessor :delete_asset
  # before_validation { self.asset.clear if self.delete_asset == '1' }
  # has_and_belongs_to_many :products
end
