class EventsController < ApplicationController
  include EventsUtil
  include MailchimpUtil

  def index
    render json: Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def create_school_list
    semester = Semester.where('season = ? AND year = ?', Semester.seasons[params[:season]], params[:year]).first
    event = semester.events.where('event_type = ?', Event.event_types[params[:event_type]]).first
    create_school_list_mailchimp(params[:school], event, params[:from_name], params[:from_email])
    render json: "Your list was created."
  end

  def email_to_slackID

    #hash of all slackID's with emails.
    #for the mentor bot b/c lots of judges 
    hash = {}
    get_slack_users.map do |member|
      puts member["id"]
      hash[member["profile"]["email"]] = member["id"]
    end

    #loop through hashEmails?
      #p = Person.where(email from hashEmails).participant
        #find participant that has correct event_id
        #set their ID to be the slackID
    hash.each do |email, id|
      puts email
      person_matching_email = Person.where('email = ?', email).first
      puts "person_matching_email: "
      puts person_matching_email
      if person_matching_email != nil 
        participant_matching_email = person_matching_email.participant
        participant_matching_email.each do |participant|
          if participant.event_id == 17
            # hash.key(value) => key
            # participant.id = slackID from hashEmails hash
            puts "ID: "
            puts id
            participant.slack_id = id
            participant.save!
          end
        end
      end
    end
  end

  # creates a new event and makes a new mailchimp list for that event
  def create
    @event = Event.new(event_params)
    make_mailchimp_list(params[:from_name], params[:from_email], @event)
    add_form_info(params[:form_id], @event)
    redirect_to :back
  end

  def semester
    @semester = Semester.where('season = ? AND year = ?', Semester.seasons[params[:season]], params[:year]).first
    render json: @semester.events.map{|event| {:form_ids => event.form_ids, :form_names => event.form_names, 
                                        :form_routes => event.form_routes, :mailchimp_ids => event.mailchimp_ids, 
                                        :event_type => event.event_type, :season => event.semester.season, 
                                        :year => event.semester.year}}
  end

  def current
    events = Event.event_types.map{|type| Event.where(event_type: type).order('created_at DESC').first}
    render json: events.compact!.map{|event| {:form_ids => event.form_ids, :form_names => event.form_names, 
                                        :form_routes => event.form_routes, :mailchimp_ids => event.mailchimp_ids, 
                                        :event_type => event.event_type, :season => event.semester.season, 
                                        :year => event.semester.year}}
  end

  def mailchimp
    HackDukeAPI::Application.load_tasks
    Rake::Task['resque:mailchimp'].invoke
    render json: {:action => 'Mailchimp synchronization performed'}
  end

  def destroy
    @event = Event.find(params[:id])
    delete_mailchimp_lists(@event)
    @event.destroy!
    redirect_to :back
  end

  def update
    @event = Event.find(params[:id])
    add_form_info(params[:added_form_id], @event)
    redirect_to :back
  end

  def event_params
    params.require(:event).permit(:event_type, :semester_id, :form_ids => [], :mailchimp_ids => [])
  end
  
end
