module EventHelper
  
  def create_events_from_prod
    puts 'Pulling events and semesters from production database...'

    options = ({basic_auth: {username: Rails.application.secrets.username, 
                               password: Rails.application.secrets.password}})

    events = HTTParty.get('https://hackduke-api.herokuapp.com/events', options)
    events.each do |event|
      Event.create(event)
    end
    semesters = HTTParty.get('https://hackduke-api.herokuapp.com/semesters', options)
    semesters.each do |semester|
      Semester.create(id: semester['semester']['id'],
                      year: semester['semester']['year'], 
                      season: semester['semester']['season'])
    end
  end

  def sync_mailchimp_on_prod
    options = ({basic_auth: {username: Rails.application.secrets.username, 
                             password: Rails.application.secrets.password}})
    events = HTTParty.get('https://hackduke-api.herokuapp.com/events/mailchimp', options)
  end

end

