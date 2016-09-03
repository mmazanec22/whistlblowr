class Complaint < ApplicationRecord
  mount_uploaders :media, MediaUploader
  validates_integrity_of :media
  before_save :create_key

  belongs_to :user
  has_many :allegations
  has_many :allegation_types, through: :allegations


  def media_urls
    # signer = Aws::S3::Presigner.new
    # urls = self.media.map{|obj| signer.presigned_url(obj, bucket: ENV['S3_BUCKET_NAME'], key: ENV['S3_KEY']).to_s}
    urls = self.media.map{|obj| obj}
    urls
  end

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