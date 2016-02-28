class Slide < ActiveRecord::Base
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  # def body
  #   attributes[:body].html_safe
  # end
end
