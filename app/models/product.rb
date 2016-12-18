# == Schema Information
#
# Table name: products
#
#  id                      :integer          not null, primary key
#  name                    :string
#  pricing                 :decimal(10, 2)
#  description             :text
#  user_id                 :integer
#  productimg_file_name    :string
#  productimg_content_type :string
#  productimg_file_size    :integer
#  productimg_updated_at   :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Product < ActiveRecord::Base

	validates_presence_of :name, :pricing, :user
	validates :pricing, numericality: { greater_than: 0 }

	belongs_to :user
	has_many :attachments, dependent: :destroy

	has_attached_file :productimg, styles: { medium: "300x300", thumb:"100x100" }, default_url: "missing.png"
	validates_attachment_content_type :productimg, content_type: /\Aimage\/.*\Z/
	

end
