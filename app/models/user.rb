class User < ApplicationRecord
  has_many :complaints, dependent: :destroy
  has_many :messages, as: :messageable

  def to_s
    contact_info = []
    contact_info << self.name if self.name != ""
    contact_info << "Anonymous" if self.name == ""
    contact_info << self.phone if self.phone != ""
    contact_info << "Phone Not Provided" if self.phone == ""
    contact_info << self.email if self.email != ""
    contact_info << "Email Not Provided" if self.email == ""
    if contact_info.length == 0
      "None"
    else
      contact_info.join("  |  ")
    end
  end

  def to_s_with_fields
    contact_info = []
    contact_info << "Name: #{self.name}" if self.name != "" && self.name != nil
    contact_info << "Name: Anonymous" if self.name == "" || self.name == nil
    contact_info << "Phone: #{self.phone}" if self.phone != "" && self.phone != nil
    contact_info << "Phone: Not Provided" if self.phone == "" || self.phone == nil
    contact_info << "Email: #{self.email}" if self.email != "" && self.email != nil
    contact_info << "Email: Not Provided" if self.email == "" || self.email == nil
    contact_info.join("  |  ")
  end

end
