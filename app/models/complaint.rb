class Complaint < ApplicationRecord
  mount_uploaders :media, MediaUploader
  validates :content, presence: true
  validates_integrity_of :media
  validate :file_size
  after_initialize :create_key

  belongs_to :user
  has_many :allegations
  has_many :allegation_types, through: :allegations
  has_many :messages

  def self.possible_statuses
    ["New", "Non-Actionable", "Pending", "Initiated-Investigation"]
  end

  def possible_other_statuses #returns non-current status options
    return Complaint.possible_statuses.reject {|st| st == self.status}
  end

  def content_shortened
    return "#{self.content[0..30]} ..." if self.content.length>20
    return self.content
  end

  def video_links_array
    self.video_links.gsub(/\s+/, "").split(",")
  end

  def create_key
    rand_key = SecureRandom.hex(5)
    until Complaint.find_by(key: rand_key) == nil
      rand_key = SecureRandom.hex(5)
    end
    self.key = rand_key if !self.key
  end

  def allegation_types_as_nice_string
    return_string = ""
    self.allegation_types.each do |a|
      return_string += "#{a.allegation_nature}, \n"
    end
    return return_string[0..-4]
  end

  def allegation_types_as_string
    return_string = self.allegation_types.map{|a| a.allegation_nature.split(" ").join("-")}.join(" ")
    return_string
  end

  def pretty_created_at
    self.created_at.to_formatted_s(:long)
  end

  def zip_media
    data = open(self.media[0])
    send_data data.read, filename: "NAME.jpg", type: "image/jpg", disposition: 'inline', stream: 'true', buffer_size: '4096'
  end

  private

  def file_size
    upload_limit = 15
    media_total = media.reduce(0) { |total, medium| total + medium.file.size.to_f }
    if media_total > upload_limit.megabytes.to_f
      errors.add(:media, "You cannot upload more than #{upload_limit.to_f}MB")
    end
  end

end
