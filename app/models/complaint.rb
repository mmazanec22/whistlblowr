class Complaint < ApplicationRecord
  mount_uploaders :media, MediaUploader
  validates_integrity_of :media
  validate :file_size
  before_save :create_key

  belongs_to :user
  has_many :allegations
  has_many :allegation_types, through: :allegations

  def add_allegations
  end

  def make_user
  end

  def content_shortened
    return "#{self.content[0..20]} ..." if self.content.length>20
    return self.content
  end

# when we allow different types of media, it would be nice to have the media index link to the object tell what kind of medium it is
  # def medium_type(medium_object)
  # end

  def create_key
    rand_key = SecureRandom.hex(5)
    until Complaint.find_by(key: rand_key) == nil
      rand_key = SecureRandom.hex(5)
    end
    self.key = rand_key
  end

  def allegation_types_as_nice_string
    return_string = ""
    self.allegation_types.each do |a|
      return_string += "#{a.allegation_nature}, \n"
    end
    return return_string[0..-4]
  end

  private

  def file_size
    upload_limit = 5
    media_total = media.reduce(0) { |total, medium| total + medium.file.size.to_f }
    if media_total > upload_limit.megabytes.to_f
      errors.add(:media, "You cannot upload more than #{upload_limit.to_f}MB")
    end
  end

end
