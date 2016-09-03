#HackDuke API
[![Build Status](https://travis-ci.org/hack-duke/hackduke-api.svg?branch=master)](https://travis-ci.org/hack-duke/hackduke-api)

##Overview
This API serves to facilitate registration for all HackDuke events through typeform. The use of typeform allows
the quick creation of forms for any event given that the questions have a corresponding field in the database. See Typeform instructions for a full list of supported questions/attributes. 

##Project Structure
- app/controllers/people_controller.rb and its modules contains most of the logic to receive webhooks/posts to modify/add people to the database
- lib/tasks contain several rake tasks (mailchimp, typeform, judgebot) and resque (job-scheduler) configuration
- pusher configuration can be found in config/initializers
- utility modules should go in app/modules
- tests can be found in the spec folder

##Getting Started
- download postgresql at http://postgresapp.com/ (for mac)
- use rbenv for ruby versioning (currently on 2.2.3)
- run cp ../hackduke-secrets/.env-hackduke-api .env (assuming that
hackduke-secrets and hackduke-api share the same parent folder)
- run bundle install and then rails s (there may be complications)
- if you're having trouble with nokogiri, you may have to run xcode-select --install
- pull database from heroku (heroku pg:pull DATABASE_URL hackduke-api_development, ask for access)

##Merging changes
Make sure to squash all commits upon merge, using Github's "squash and merge" functionality. 

##Spacing
Please use 2 spaces to indent

##Testing
- Run bundle exec rspec spec to start the mailchimp + typeform integration test
- If the mailchimp test is failing, it may be because mailchimp is responding too slowly (try again)
or there have been invalid emails added (you can filter them out in the MailchimpUtil module to get 
the test to pass again)

##Services
- Typeform: bundle exec rake resque:typeform
- Mailchimp: bundle exec rake resque:mailchimp
- Crons (typeform, mailchimp): bundle exec rake resque:scheduler (see scheduler at config/schedule.yml)
- Run bundle exec rake resque:work QUEUE=high and redis-server before the scheduler is started

##Deployment instructions
- currently using heroku for deployment
- replace bundle exec with heroku run to run services on heroku

##Continous integration
- currently using travis CI to run the tests on every build and deploy to heroku on merges to master

##Typeform instructions
- All typeforms must be given a route with the following format route_(update/receive)_(participant/judge/speaker/mentor) (e.g. route_receive_participant would be the route for new participant registration)
- receive or update refers to whether you are creating a new person or simply updating one
- for update forms + mailchimp, use mailchimp merge tags to fill in the email hidden field so that people can be identified automatically
- the participant/judge/speaker/mentor refers to the role the person will play in an event
- the following roles are currently supported
	* participant
	* judge
	* speaker
	* mentor
- routes should be placed as a hidden field key in the typeform
- the questions for the forms must contain keywords, which are the model fields (e.g. what is your first name would be a good question for first_name, see the the Ideate Registration typeform for more examples)
- for all roles, you can include the following keywords/questions
	* email (this field is mandatory)
	* first name
	* last name
	* gender
	* race
	* phone
- for participants, the following are currently supported: 
  * graduation year
  * over eighteen
  * attending (used for confirmation)
  * major
  * school
  * dietary restrictions
  * website 
  * resume
  * github
  * travel (used for reimbursements)
  * portfolio
  * skills
  * race
- for mentors, 
	* skills
- for speakers, 
	* topic
	* date
- for judges, 
	* skills
- lastly, custom questions must be prefixed with Q: (e.g. Q: Why do you want to attend HackDuke?)
