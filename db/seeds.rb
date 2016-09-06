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
  "Ethics",
  "Other"]

allegation_types.sort_by! { |a| a.downcase }

allegation_types.each do |a|
  AllegationType.create(allegation_nature: a)
end

Investigator.create(username: "admin", email: "whistlblowrs@gmail.com", password: "thesecretsix", admin: true)

User.create!(name: "Jane Doe", phone: "4853928475")

complaint_content = ["My alderman bribed people to campaign on city property", "My alderman bribed people to campaign on city property"]

complaint_content.each do |c|
  complaint = Complaint.create!(content: c, user_id: User.all.sample.id)
  2.times do
    allegation = Allegation.create(complaint_id: complaint.id, allegation_type_id: AllegationType.all.sample.id)
  end
end
