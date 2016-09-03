allegation_types = [
  "Abuse of Authority",
  "Bribery",
  "Campaign Finance Violation",
  "Conflict of Interest",
  "Contract Inducement",
  "Extortion",
  "Electioneering Activities on City Time and/or Property",
  "Harassment",
  "Sexual Harassment",
  "Improper Influence",
  "Improper/Fraudulent Record Keeping",
  "Negligent Fiduciary Duty",
  "Post Employment Restriction",
  "Prohibited Political Activity",
  "Grant Fraud",
  "Financial Crime",
  "Other Criminal",
  "Ethics"]

allegation_types.sort_by! { |a| a.downcase }

allegation_types.each do |a|
  AllegationType.create(allegation_nature: a)
end

User.create!(name: "Anonymous", phone: "4853928475")
User.create!(phone: "4852958475")

complaint_content = ["I saw my alderman embezzling money while demanding oral sex from an intern", "My alderman bribed people to campaign on city property", "My alderman used grant money to buy equipment for her husband's company to which she then awarded a contract"]

complaint_content.each do |c|
  complaint = Complaint.create!(key: SecureRandom.hex, content: c, user_id: User.all.sample.id)
  2.times do
    allegation = Allegation.create(complaint_id: complaint.id, allegation_type_id: AllegationType.all.sample.id)
  end
end