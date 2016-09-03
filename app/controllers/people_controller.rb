class PeopleController < ApplicationController
  respond_to :json, :html
  include PeopleUtil
  include TypeformWebhook
  include TypeformUtil
  include EventsUtil

  def ids
    semester = Semester.where('season = ? AND year = ?', Semester.seasons[params[:season]], params[:year]).first
    event = semester.events.where('event_type = ?', Event.event_types[params[:event_type]]).first
    role_type = params[:role]
    roles = event.send(role_type.pluralize)
    render json: roles.map { |role| role.id }
  end

  def roles
    semester = Semester.where('season = ? AND year = ?', Semester.seasons[params[:season]], params[:year]).first
    event = semester.events.where('event_type = ?', Event.event_types[params[:event_type]]).first
    role_type = params[:role]
    roles = event.send(role_type.pluralize)
    render json: roles.map {|role| {:person => role.person, :role => role}}
  end

  def id
    role_type = params[:role]
    model = role_type.classify.constantize
    render json: model.find(params[:id])
  end

  def update_role_external
    role_type = params[:role]
    model = role_type.classify.constantize
    role = model.find(params[:id])
    role.update_attributes(role_params(params[:role], params))
    render json: role
  end
  
  # push means the request came from a webhook and the client should be updated automatically
  def update_role_push
    params_hash = parse_push_json(params)
    if params_hash.size == 0
      render json: {:errors => "No form route provided"}
    end
    update_role_logic(params_hash, true)
  end

  def receive_role_push
    params_hash = parse_push_json(params)
    if params_hash.size == 0
      render json: {:errors => "No form route provided"}
    end
    receive_role_logic(params_hash, true)
  end

  def receive_role
    receive_role_logic(params)
  end

  def update_role
    update_role_logic(params)
  end

  # shows all info given a season, year, event_type grouped by person and alphabetically
  # each person has info from the person model as well as the role's models
  def event
    semester = Semester.where('season = ? AND year = ?', Semester.seasons[params[:season]], params[:year]).first
    event = semester.events.where('event_type = ?', Event.event_types[params[:event_type]]).first
    roles = []
    Person.roles.keys.each do |role_type|
      model = role_type.classify.constantize
      roles += model.where('event_id = ?', event.id).map{|role| 
        {
          :person_id => role.person_id, 
          :role => role.attributes.except('id', 'person_id', 'slack_id', 'created_at', 'updated_at'),
          :role_type => role_type
        } 
      }
    end
    output = roles.group_by{|x| x[:person_id]}.map{|k,v| 
      { :person => Person.find(k).attributes.slice('first_name', 'last_name', 'phone', 'email', 'gender', 'race'),
      :roles => v.map{|ele| { role_with_status(ele[:role], ele[:role_type]) => ele[:role] } }
      }
    }
    render json: output.sort_by {|v| v[:person]['first_name'].downcase}
  end

end
