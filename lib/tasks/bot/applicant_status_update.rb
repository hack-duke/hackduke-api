
# first sorts participants by average_rating
# simultaneously creates csv to be saved at /public/applicant_statuses.csv and
# updates the statuses of participants based on their score
def update_participant_statuses(participants, accept_num, waitlist_num, results, season, event, year)
  sorted_participants = []
  results.each do |order|
    if order.to_i < participants.length
      sorted_participants << participants[order.to_i]
    end
   end
   CSV.open(Rails.root.to_s + "/public/applicant_statuses_#{event}_#{season}_#{year}.csv", "wb") do |csv|
     sorted_participants.each_with_index do |participant, index|
       if index < accept_num
         participant.status = "accepted"
       elsif index < accept_num + waitlist_num
         participant.status = "waitlisted"
       else
         participant.status = "rejected"
       end
       participant.save!
       csv << [participant.person.first_name, participant.person.last_name, participant.id, participant.status]
     end
   end
end
