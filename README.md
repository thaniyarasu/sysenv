## Welcome to Sysenv


Sysenv is a library is used to apply System ENV environment(ENV) variable into 
Application Environment variables. that means apply System Specific Environment variables on top of Project Specific Environment variables.

mainly used for ruby application , particularly rails 4.2 + application

## Getting Started

1. Install Sysenv at the command prompt if you haven't yet:

  gem install sysenv
  
  or 

  gem 'sysenv'    



2. Example:
  ~$ API_SECRET_KEY="production_value" irb -rsysenv
  >> sysenv = Sysenv.new
  >> sysenv.apply({api:{secret:{key: 'default_value',cert:'certificate'}}})
  => {:api=>{:secret=>{:key=>"production_value", :cert=>"certificate"}}} 


3. Run with rails 4.2+ application 

  add "sysenv" gem into Gemfile 

  gem 'sysenv'  

  bundle install
  
  open "RAILS_ROOT/config/envs.yml" and add
  
  default: &default
    github:
      username: 'un'
      password: 'pw'

  development:
    <<: *default

  test:
    <<: *default

  production:
    <<: *default


  open "RAILS_ROOT/config/application.rb"


  module RailsApp
    class Application < Rails::Application
      ...
      ...
      ... 
      config.envs = Sysenv.new.apply(YAML.load_file(root+"config/envs.yml")[Rails.env])
    end
  end

  done.
  after this you can refer Rails.application.config.envs[:github][:username] at anywhere in your application. 

  ~$ rails consile
  >> Rails.application.config.envs[:github][:username]
  #un
  >> quit

  ~$ GITHUB_USERNAME="myusernmae" rails consile
  >> Rails.application.config.envs[:github][:username]
  #myusername
  >> quit


  from now onwards whenever you add any system ENV variables which have place holder at RAILS_ROOT/config/envs.yml file will be override by Sysenv

  very usefull for deploying rails app into heroku, who don't want to commit RAILS_ROOT/config/envs.yml file into github repository.

  because heroku use ENV variables for secrets (by heroku add GITHUB_USERNAME 'blahblahblah')
  where sysenv will be most useful.

  happy deploying !!!



## License

Sysenv is released under the [MIT License](http://www.opensource.org/licenses/MIT).