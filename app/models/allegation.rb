class Allegation < ApplicationRecord
  belongs_to :complaint
  belongs_to :allegation_type

end
