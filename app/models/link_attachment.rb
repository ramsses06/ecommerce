# == Schema Information
#
# Table name: link_attachments
#
#  id              :integer          not null, primary key
#  link_id         :integer
#  expiration_date :datetime
#  attachment_id   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class LinkAttachment < ActiveRecord::Base
  before_create :set_defaults
  belongs_to :link
  belongs_to :attachment

  def is_invalid?
    (DateTime.now > self.expiration_date)
  end

  private
    def set_defaults
      self.expiration_date = DateTime.now + 30.minutes
    end

end
