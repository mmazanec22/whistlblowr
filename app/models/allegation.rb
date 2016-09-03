class Allegation < ApplicationRecord
  belongs_to :complaint
  belongs_to :allegation_type

  accepts_nested_attributes_for :allegation_type

end
