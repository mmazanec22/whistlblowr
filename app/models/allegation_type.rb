class AllegationType < ApplicationRecord
  has_many :allegations
  has_many :complaints, through: :allegations

end
