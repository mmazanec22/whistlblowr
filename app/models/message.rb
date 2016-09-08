class Message < ApplicationRecord
  belongs_to :messageable, polymorphic: true
  belongs_to :complaint

  def sender
    if self.messageable_type == "Investigator"
      # if Investigators want emails exposed, use this instead:
      # messageable.email
      "Investigator"
    else
      "Anonymous"
    end
  end

end
