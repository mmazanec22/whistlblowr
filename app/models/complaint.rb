class Complaint < ApplicationRecord
  mount_uploaders :media, MediaUploader
  before_save :create_key

  belongs_to :user
  has_many :allegations
  has_many :allegation_types, through: :allegations

  def add_allegations
  end

  def make_user
  end

  def create_key
    rand_key = SecureRandom.hex(5)
    until Complaint.find_by(key: rand_key) == nil
      rand_key = SecureRandom.hex(5)
    end
    self.key = rand_key
  end

  def allegation_types_as_nice_string
    return_string = ""
    self.allegation_types.each do |a_t|
      return_string += "#{a_t.allegation_nature}, "
    end
    return return_string
  end

end
