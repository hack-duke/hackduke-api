
module MailchimpUtil

  def gibbon
  Gibbon::Request.new(api_key: Rails.application.secrets.mailchimp_api_key)
  end

  # add emails here if there are invalid emails in the database that won't appear on mailchimp
  def filter_invalid_emails(emails)
    invalid_emails = ['hi@gmail.cm', 'asdasd']
    emails.select{|email| !invalid_emails.include? email.strip.downcase}
  end

  def retrieve_emails_for_event(event)
    emails = []
    Person.roles.keys.each_with_index do |role, index|
      if index == 0 
        event.mailchimp_ids[index].split(',').each do |mid|
        	emails << retrieve_all_members(mid)
        end
      else
        emails << retrieve_all_members(event.mailchimp_ids[index])
      end
    end
  emails
  end

  def add_to_mailchimp_list(event, person, cleaned_email, mailchimp_id)
    gibbon = Gibbon::Request.new(api_key: Rails.application.secrets.mailchimp_api_key)
    begin 
      puts gibbon.lists(mailchimp_id).members.create(
      body: {email_address: cleaned_email, status: 'subscribed', merge_fields:
      {FNAME: person.first_name, LNAME: person.last_name}})
    rescue Gibbon::MailChimpError => e
      Rails.logger.debug e.raw_body
    end
  end

  def delete_mailchimp_lists(event)
    event.mailchimp_ids.each do |id|
      begin
        id.split(',').each do |split_id|
          gibbon.lists(split_id).delete()
        end
      rescue
        logger.error 'Lists do not exist on mailchimp'
      end
    end
  end

  # makes mailchimp lists for every role as well as the participant and statuses
  # the mailchimp_ids for the participant and status is stored as comma-separated
  def make_mailchimp_list(from_name, from_email, event)
    Person.roles.keys.each_with_index do |role, index|
      if index == 0 
        participant_ids = []
        Participant.statuses.keys.each do |s|
          response = gibbon.lists.create(make_mailchimp_hash(from_name, from_email, event, role, s))
          participant_ids << response['id']
        end
        event.mailchimp_ids << participant_ids.join(',')
      else
        response = gibbon.lists.create(make_mailchimp_hash(from_name, from_email, event, role))
        event.mailchimp_ids << response['id']
      end
    end
  end

  def make_mailchimp_hash(from_name, from_email, event, role, modifier='')
    name = "#{event.event_type.humanize.titleize} #{event.semester.season.capitalize} #{event.semester.year} #{role.capitalize}s #{modifier.capitalize}"
    { body: {name: name, contact: { company: 'HackDuke', address1: '450 Research Dr',
     city: 'Durham', state: 'North Carolina', zip: '27705', country: 'US',
     phone: '(703) 662-1293' }, permission_reminder: 'You registered for this event',
     campaign_defaults: { from_name: from_name, from_email: from_email,
     subject: name, language: 'English'}, email_type_option: true} }
  end

  def retrieve_all_members(mid)
    emails_to_filter = ['']
    gibbon.lists(mid).members.retrieve(params: {'count': '1000', 
    'status': 'subscribed', 'fields': 'members.email_address'})['members']
    .map{|member| member['email_address'].strip.downcase}
  end

end