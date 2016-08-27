# determines whether the judging session is active and replies if there's not an active session
def active_judging_session(client, data)
    if !@judging_status
      client.say(text: "There is not an active judging session", channel: data.channel)
    end
    return @judging_status
end

# validates the season
def validate_season(season, client, data)
  seasons = Semester.all.map {|sem| sem.season}.uniq
  valid = Semester.seasons.include? season
  if !valid 
    client.say(text: generate_error_from_options(seasons, "season"), channel: data.channel)
  end
  valid
end

# validates the year
def validate_year(year, client, data)
  years = Semester.all.map {|sem| sem.year.to_s }.uniq
  valid = years.include? year.to_s
  if !valid 
    client.say(text: generate_error_from_options(years, "year"), channel: data.channel)
  end
  valid
end

# validates the type
def validate_type(type, client, data)
  valid = @bot_types.include? type
  if !valid
    client.say(text: generate_error_from_options(@bot_types, "type"), channel: data.channel)
  end
  valid
end

# validates the event
def validate_event(event, client, data)
  events = Event.all.map {|event| event.event_type}.uniq
  valid = events.include? event
  if !valid
    client.say(text: generate_error_from_options(events, "event"), channel: data.channel)
  end
  valid
end

# generates an error string from a category and string options array
def generate_error_from_options(options, category)
  list = ""
  options.each do |elem|
    list << elem + ", "
  end
  list.chop!
  list.chop!
  "Please enter a valid " + category + " out of " + list
end