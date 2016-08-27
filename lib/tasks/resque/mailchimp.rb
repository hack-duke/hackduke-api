class Mailchimp

  def self.perform(method)
    self.new.send(method)
  end

  def subscribe
   Event.where(active: 1).each do |event|
     batch_subscribe(make_participants_array(event), make_mailchimp_id_array(event))
   end
  end

  def unsubscribe
  	Event.where(active: 1).each do |event|
     batch_unsubscribe(make_participants_array(event), event.mailchimp_ids[0].split(','))
   end
  end

  def make_participants_array(event)
    participants = []
    event.participants.each do |participant|
      if participant.attending == 1
          participant.status = 2
          participant.save!
        end
        participants << participant
      end
    participants
  end

  def make_mailchimp_id_array(event)
    mailchimp_ids = []
    event.participants.each do |participant|
      mailchimp_ids << event.mailchimp_ids[0].split(',')[Participant.statuses[participant.status]]
    end
    mailchimp_ids 
  end

  def api
    Gibbon::Request.new(api_key: Rails.application.secrets.mailchimp_api_key)
  end

  def subscriber_hash(email)
    Digest::MD5.hexdigest(email)
  end

  def batch_subscribe(participants=[], mailchimp_ids=[])
    operations = []
    participants.each_with_index do |participant, index|
      person = participant.person
      operations.append({
        :method => "PUT",
        :path => "/lists/#{mailchimp_ids[index]}/members/#{subscriber_hash(person.email)}",
        :body => {
          :email_address => person.email,
          :status => "subscribed",
          :merge_fields => { :FNAME => person.first_name,
                             :LNAME => person.last_name}
        }.to_json
      })
    end
    puts api.batches.create(body: {:operations => operations})
  end

  def batch_unsubscribe(participants=[], mailchimp_ids=[])
    operations = []
    participants.each do |participant|
      person = participant.person
      mailchimp_ids.each do |id|
        operations.append({
          :method => "PUT",
          :path => "/lists/#{id}/members/#{subscriber_hash(person.email)}",
          :body => {
            :email_address => person.email,
            :status => "unsubscribed",
            :merge_fields => { :FNAME => person.first_name,
                               :LNAME => person.last_name}
          }.to_json
        })
      end
    end
    puts api.batches.create(body: {:operations => operations})
  end

end