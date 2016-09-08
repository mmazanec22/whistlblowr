class User < ApplicationRecord
  has_many :complaints
  has_many :messages, as: :messageable

  def to_s
    contact_info = []
    contact_info << self.name if self.name != ""
    contact_info << "Anonymous" if self.name == ""
    contact_info << self.phone if self.phone != ""
    contact_info << "Not Provided" if self.phone == ""
    contact_info << self.email if self.email != ""
    contact_info << "Not Provided" if self.email == ""
    p self
    if contact_info.length == 0
      "None"
    else
      contact_info.join(" | ")
    end
  end

end
