class Complaint < ApplicationRecord
  mount_uploaders :media, MediaUploader
  before_save :create_key

  belongs_to :user
  # has_many :media
  has_many :allegations
  has_many :allegation_types, through: :allegations

  accepts_nested_attributes_for :allegations

  def add_allegations
  end

  def make_user
  end

  def create_key
    self.key = SecureRandom.hex(5)
  end


end
