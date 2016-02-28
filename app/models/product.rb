class Product < ActiveRecord::Base
  acts_as_sellable_with_variants
  has_many :images
  scope :mens, -> { where(mens:true) }
  scope :womens, -> { where(mens:false) }
  # scope :search, -> { where(mens:true) }
  scope :gender, -> (gender) { where mens: gender == 'true' }
  # scope :size, -> (size) { where status: status }
  # scope :location, -> (location_id) { where location_id: location_id }
  # scope :starts_with, -> (name) { where("name like ?", "#{name}%")}
end
