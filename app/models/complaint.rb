class Complaint < ApplicationRecord
  belongs_to :user
  has_many :media
  has_many :allegations
  has_many :allegation_types, through: :allegations

  def allegation_types_as_nice_string
    return_string = ""
    self.allegation_types.each do |a_t|
      return_string += "#{a_t.allegation_nature}, "
    end
    return return_string
  end
end
