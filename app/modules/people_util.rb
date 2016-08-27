require 'logger'

module PeopleUtil

  # updates a person's information in its role and person model 
  # email is the primary identifier and we must be sure the cleaned version is in the database
  def update_role_logic(params, push=false)
    email = clean_email(params[:person][:email])
    event = Event.where("'#{params[:form_id]}' = ANY (form_ids)").first
    model = params[:role].classify.constantize
    role = model.joins(:person).where('people.email = ? AND event_id = ?', email, event.id).first
    if role != nil
      role_params = params[params[:role].to_sym]
      if role_params.to_unsafe_h.size > 0 
        # update attributes if parameters for the role have been provided
        role.update_attributes(role_params(params[:role], params))
        # update status if participant and attending has become true
        if params[:role] == 'participant' && role_params[:attending] == 1
          role.status = 2
        end
      end
      append_to_submission_history(role, params)
      # updates attributes for the person (email is always provided)
      role.person.update_attributes(person_params(params))
      role.person.email = email
      # save person and role
      role.person.save!
      role.save!
      if push 
        trigger_push
      end
      render json: {:person => role.person, role_sym(params[:role]) => role}
    else
      render json: {:errors => 'That role does not exist'}
    end
  end

  # makes new role in database given information and form_id and adds to mailchimp list
  # makes new person as well if he/she doesn't exist in the database
  # updates existing person if he/she is in the database already (the last submission is taken)
  # event is identified by form_id so forms cannot be re-used among events
  def receive_role_logic(params, push=false)
    email = clean_email(params[:person][:email])
    event = Event.where("'#{params[:form_id]}' = ANY (form_ids)").first
    model = params[:role].classify.constantize
    role = model.joins(:person).where('people.email = ? AND event_id = ?', email, event.id).first
    role_sym = params[:role].parameterize.underscore.to_sym 
    if role == nil
    # creates new role if the role is not in the database
    role = model.new(role_params(params[:role], params))
    role.event = event
    existing_person = person_exists(email)
      if existing_person == nil
        # creates new person if person is not in the database
        person = Person.new(person_params(params))
        person.email = email
        role.person = person
        existing_person = person
      else
        # updates the person if the person is in the database
        role.person = existing_person
        role.person.update_attributes(person_params(params))
        role.person.email = email
      end
      append_to_submission_history(role, params)
      # save person and role
      role.person.save!
      role.save!
      # determines mailchimp_id by role and adds to list 
      # doesn't matter if he/she already exists
      mailchimp_id = event.mailchimp_ids[Person.roles[params[:role]]].split(',')[0]
      add_to_mailchimp_list(@event, existing_person, email, mailchimp_id)
      if push 
        trigger_push
      end
      render json: {:person => person, role_sym(params[:role]) => role}
    else
    # updates the role if the role is in the database
    update_role_logic(params, push)
    end
  end

  def role_sym(role)
    role.parameterize.underscore.to_sym 
  end

  def append_to_submission_history(role, params)
    role.person.submit_date << params[:submit_date]
    role.person.form_id << params[:form_id]
  end

  # triggers push to client when roles have been added
  def trigger_push
    Pusher.trigger('update_channel', 'trigger_update', {
      message: 'fetch roles'
    })
  end

  def role_with_status(role, type)
    add_on = ''
    if role.key? 'status'
    add_on = ' ' + role['status']
    end
    type + add_on
  end

  def clean_email(email) 
    return email.strip.downcase
  end

  def person_exists(email)
    Person.where('email = ?', email).first
  end

  # parameters dynamically determine by the person's role
  # must be updated every time schema changes
  def role_params(role, params)
    params = ActionController::Parameters.new(params.to_unsafe_h)
    case Person.roles[role]
    when 0
      return params.require(:participant).permit(:status, :school, :website, :resume, :attending, :github, 
    																				 :portfolio, :graduation_year, :major, :over_eighteen, :slack_id, 
    																				 :skills => [], :custom => [], :dietary_restrictions => [])
    when 1
      return params.require(:speaker).permit(:slack_id, :date => [], :topic => [])
    when 2
      return params.require(:judge).permit(:slack_id, :skills => [])
    when 3
      return params.require(:mentor).permit(:slack_id, :skills => [])
    else 
      return {}
    end
  end

  def person_params(params)
    params = ActionController::Parameters.new(params.to_unsafe_h)
    params.require(:person).permit(:first_name, :gender, :last_name, :email, :phone, :slack_id)
  end

end