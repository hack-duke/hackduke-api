require 'mandrill'

class PeopleController < ApplicationController
  respond_to :json, :html
  include PeopleUtil
  include TypeformWebhook
  include TypeformUtil
  include EventsUtil
  include BCrypt

  def ids
    semester = Semester.where('season = ? AND year = ?', Semester.seasons[params[:season]], params[:year]).first
    event = semester.events.where('event_type = ?', Event.event_types[params[:event_type]]).first
    role_type = params[:role]
    roles = event.send(role_type.pluralize)
    render json: roles.map { |role| role.id }
  end

  def role
    semester = Semester.where('season = ? AND year = ?', Semester.seasons[params[:season]], params[:year]).first
    event = semester.events.where('event_type = ?', Event.event_types[params[:event_type]]).first
    model = params[:role].classify.constantize
    role = model.joins(:person).where('people.email = ? AND event_id = ?', params[:email], event.id).first
    if role != nil 
      render json: {:person => role.person, :role => role}
    else
      render json: {:errors => 'That role does not exist'}
    end
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

  def authenticate
    @user = Person.find_by_email(params[:email])
    permanent_pass_correct = false
    temporary_pass_correct = false
    temporary_pass_expired = true
    if @user != nil
      if @user.session_token == params[:session_token]
        session_token = SecureRandom.hex
        @user.session_token = session_token
        @user.save!
        render json: {:success => "Person successfully authenticated", :authentication => "permanent", :session_token => session_token}
        return 
      end
      if @user.password != nil
        unencrypted_password = Password.new(@user.password)
        permanent_pass_correct = unencrypted_password == params[:password]
      elsif @user.temp_password != nil
        unencrypted_temp_password = Password.new(@user.temp_password)
        temporary_pass_correct = unencrypted_temp_password == params[:password]
        if @user.temp_password_datetime != nil
          temp_password_datetime = DateTime.parse(@user.temp_password_datetime.to_s)
          temporary_pass_expired = ((DateTime.now - temp_password_datetime)*24*60).to_i > 30
        end
      else
        render json: {:errors => "Please request a temporary password first!"}
      end
      if temporary_pass_correct
        if !temporary_pass_expired
          render json: {:success => "Please set your new password!", :authentication => "temporary"}
        else
          render json: {:errors => "Your temporary password has expired, please request another one!"}
        end
      elsif permanent_pass_correct
        session_token = SecureRandom.hex
        @user.session_token = session_token
        @user.save!
        render json: {:success => "Person successfully authenticated", :authentication => "permanent", :session_token => session_token}
      elsif @user.password != nil || @user.temp_password != nil
        render json: {:errors => "Your password was invalid, please try again!"}
      end
    else
      render json: {:errors => "Your email could not be found!"}
    end
  end

  def set_password
    @user = Person.find_by_email(params[:email])
    if @user != nil
      session_token = SecureRandom.hex
      @user.session_token = session_token
      @user.password = Password.create(params[:password])
      @user.temp_password = nil
      @user.temp_password_datetime = nil
      @user.save!
      render json: {:success => "New password set successfully", :authentication => "permanent", :session_token => session_token}
    else
      render json: {:errors => "Your email could not be found!"}
    end 
  end

  def reset_password
    @user = Person.find_by_email(params[:email])
    if @user != nil 
      temp_password = SecureRandom.hex(8) 
      mandrill = Mandrill::API.new Rails.application.secrets.mandrill_key
      message = {
       "tags"=>["password-resets"],
       "to"=>
          [{"name"=> @user.first_name + ' ' + @user.last_name,
              "type"=>"to",
              "email"=> params[:email]}],
       "from_name"=>"HackDuke",
       "subject"=>"Your HackDuke password",
       "merge"=>true,
       "from_email"=>"register@hackduke.org",
       "global_merge_vars": [{
          "name": "PASSWORD",
          "content": temp_password,
        }],
      }
      
      template_name = "Temporary Password"
      template_content = [{}]

      async = false
      ip_pool = "Main Pool"
      send_at = DateTime.now.to_s
      template_result = mandrill.messages.send_template template_name, template_content, message, async, ip_pool, send_at
      @user.temp_password = Password.create(temp_password)
      @user.temp_password_datetime = DateTime.now
      @user.password = nil
      @user.save!
      render json: {:success => "Temporary password successfully sent!"}
    else
      render json: {:errors => "Your email could not be found!"}
    end
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
