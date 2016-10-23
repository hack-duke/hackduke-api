require 'mandrill'

module MailchimpUtil
  include BCrypt

  def send_password(user, email, first_time)
    temp_password = SecureRandom.hex(8)

    if first_time
      template_name = "CodeForGoodWelcome2016"
      template_content = [{}]
      subject = 'Thanks for registering!'
    else
      template_name = "CodeForGoodReset2016"
      template_content = [{}]
      subject = 'Your HackDuke password'
    end

    mandrill = Mandrill::API.new Rails.application.secrets.mandrill_key
    message = {
     "tags"=>["password-resets"],
     "to"=>
        [{"name"=> user.first_name + ' ' + user.last_name,
            "type"=>"to",
            "email"=> email}],
     "from_name"=>"HackDuke",
     "subject"=>subject,
     "merge"=>true,
     "from_email"=>"hackers@hackduke.org",
     "global_merge_vars": [
        {
          "name": "PASSWORD",
          "content": temp_password,
        },
        {
          "name": "LIST:COMPANY",
          "content": "HackDuke",
        },
        {
          "name": "HTML:LIST_ADDRESS_HTML",
          "content": "hackers@hackduke.org",
        }
      ],
    }

    async = false
    ip_pool = "Main Pool"
    send_at = DateTime.now.to_s
    template_result = mandrill.messages.send_template template_name, template_content, message, async, ip_pool, send_at
    user.temp_password = Password.create(temp_password)
    user.temp_password_datetime = DateTime.now
    session_token = SecureRandom.hex
    user.session_token = session_token
    user.save!
    user.password = nil
    user.save!
    user
  end

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

  #adds one person
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

  def create_school_list_mailchimp(school, event, name, email)
  #   gibbon = Gibbon::Request.new(api_key: Rails.application.secrets.mailchimp_api_key)
  #   begin 

  #  same as everywhere else. pass in event
  #     #find the event
  #     #make list using that event
  #     #name the list based on the school you got
  #     #query loop through them and call add_to
  #     #use hte Id you get from that to add  hte particiapnts

  #     #cleaned_email
  #     #get the person's email
  #     #person.email
  #     #pass in mailchimp_id from making the list
  #       #response['id']
  #       #response['id'] mailchimp_id
  #     #participant.where(event_id==event_id_specified && school == Duke)

  #     #Participant.where('people.email = ? AND event_id = ?', params[:email], event.id)
      all_participants = Participant.where('event_id = ? AND school = ?', event.id, school)



  #     #filter based on school. 

  #     # semester = Semester.where('season = ? AND year = ?', Semester.seasons[params[:season]], params[:year]).first
  #     # event = semester.events.where('event_type = ?', Event.event_types[params[:event_type]]).first

  #     #hardcode the school, 
  #     #participant and school
  #     #participant is role


  #     # event.sends("participants")   
  #     # to get all people
  #     # loop through participants
  #     # participants.person
  #     # first name, last name, email from people then add to mailchimp list
  #     # to get event, find semester then find eventtype

  #     #how do i test this

  #     puts gibbon.lists(mailchimp_id).members.create(
  #     body: {email_address: cleaned_email, status: 'subscribed', merge_fields:
  #     {FNAME: person.first_name, LNAME: person.last_name}})

  #   rescue Gibbon::MailChimpError => e
  #     Rails.logger.debug e.raw_body

  response = gibbon.lists.create(make_mailchimp_hash(name, email, event, "participant", school))
  #loop through all participants
  all_participants.each { |participant|  add_to_mailchimp_list(event, participant.person, participant.person.email, response['id'])}


  

  #role = participant
  #modifier = school

  #   end
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
    name = "#{event.event_type.humanize.titleize} #{event.semester.season.capitalize} #{event.semester.year} #{role.capitalize}s #{modifier.titleize}"
    { body: {name: name, contact: { company: 'HackDuke', address1: '450 Research Dr',
     city: 'Durham', state: 'North Carolina', zip: '27705', country: 'US',
     phone: '(703) 662-1293' }, permission_reminder: 'You\'re interested in HackDuke',
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
