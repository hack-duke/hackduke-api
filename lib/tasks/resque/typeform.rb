require_relative '../../../app/modules/typeform_data'
require_relative '../../../app/modules/typeform_util'

class Typeform
  include TypeformData
  include TypeformUtil

  def self.perform(method)
    self.new.send(method)
  end

  # loops through all active events and updates the database according to the event's forms
  # webhook should take care of all new entries, but this cron will clean them up if something goes wrong
  def sync
    endpoint = 'https://hackduke-api.herokuapp.com'
    generate_all_responses.each do |response|
      HTTParty.post(endpoint + response[:route], response[:params])
    end
  end

end
