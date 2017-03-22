# Jobs

TODO: Write a gem description

## Current state

[![Build Status](https://travis-ci.org/wdiechmann/jobs.svg?branch=master)](https://travis-ci.org/wdiechmann/jobs)

[![Gem Version](https://badge.fury.io/rb/jobs.png)](http://badge.fury.io/rb/sinderella)

[![Coverage Status](https://coveralls.io/repos/wdiechmann/jobs/badge.png)](https://coveralls.io/r/wdiechmann/jobs)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jobs'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jobs

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/jobs/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Building the gem

1. 		install or update bundler
2. 		run `bundle gem jobs`
3. 		add dependencies to jobs/jobs.gemspec
4. 		add task to Rakefile
5. 		add 'spec' folder and first test file within, jobs\_spec.rb and it's helper: spec\_helper.rb
6. 		add 'Guardfile' and contents
7. 		add repository to github.com/wdiechmann
8. 		add travis-ci.org integration
9. 		add coveralls.io code coverage integration
10. 	add coveralls gem to jobs.gemspec
11.		add coveralls helper to our spec_helper
12.		add badges to the README for CI, RubyGem, and Coveralls 
13.		finish the job.gemspec
14.		do a first build of the gem with `gem build jobs.gemspec`
15.		do a first install of the gem with `gem install ./jobs-0.0.2.gem`
16.		do a first release with 
	- rake build
	- rake install
	- rake release