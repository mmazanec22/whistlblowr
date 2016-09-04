class User < ApplicationRecord
  has_many :complaints
  has_many :messages, as: :messageable

  def to_s
    contact_info = []
    contact_info << self.name
    contact_info << self.phone
    contact_info << self.email

    if contact_info.length == 0
      "None"
    else
      contact_info.join(" | ")
    end
  end

end
