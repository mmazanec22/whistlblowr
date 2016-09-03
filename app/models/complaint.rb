class Complaint < ApplicationRecord
  belongs_to :user
  has_many :media
  has_many :allegations
  has_many :allegation_types, through: :allegations

end
