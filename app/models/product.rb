class Product < ActiveRecord::Base

	validates_presence_of :name, :pricing, :user
	validates :pricing, numericality: { greater_than: 0 }

	belongs_to :user

	has_attached_file :productimg, styles: { medium: "300x300", thumb:"100x100" }, default_url: "missing.png"
	validates_attachment_content_type :productimg, content_type: /\Aimage\/.*\Z/
	

end
