# == Schema Information
#
# Table name: links
#
#  id              :integer          not null, primary key
#  product_id      :integer
#  expiration_date :datetime
#  downloads       :integer
#  downloads_limit :integer
#  custom_id       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  email           :string
#

require 'digest/md5'
class Link < ActiveRecord::Base
  before_create :set_defaults
  after_create :send_email
  belongs_to :product
  has_many :link_attachments

  def is_invalid?
    (DateTime.now > self.expiration_date || self.downloads >= 100)
  end

  def update_downloads
    self.update(downloads: self.downloads+1)
  end

  #crear link de attachments
  def create_attachment_links
    product.attachments.each do |attachment|
      self.link_attachments.create(attachment_id: attachment.id)
    end
  end

  #Traer solo los ultimos links
  def last_attachments_links
    link_attachments.order('id DESC').limit(product.attachments.count).order('id ASC')
  end

  private
    def set_defaults #crea un HASH que se utilizara para el link de descarga
      self.custom_id = Digest::MD5.hexdigest("#{DateTime.now}#{self.id}#{self.product_id}")
      self.downloads ||= 0 #si downloads es nulo lo convierte en 0 antes de crear
    end

    def send_email
      LinkMailer.download_link(self).deliver_now
    end

end
