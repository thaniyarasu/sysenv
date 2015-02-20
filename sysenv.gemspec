Gem::Specification.new do |s|
  s.name        = 'sysenv'
  s.version     = '0.0.1'
  s.date        = '2015-02-20'
  s.summary     = "Sysenv ! will load app envs and override with system envs"
  s.description = <<-STRING
  In Most Rails Application config/envs.yml file will be there , some
  time we have to use System settings env values . so this gem is created, this
  this will Override Project Envs with system envs
STRING
  s.authors     = ["Thaniyarasu Kannusamy"]
  s.email       = 'thaniyarasu@gmail.com'
  s.files       = ["lib/sysenv.rb", "lib/sysenv/sysenv.rb"]
  s.homepage    = 'https://github.com/thaniyarasu/sysenv'
  s.license     = 'MIT'
  s.add_runtime_dependency 'activesupport', '>= 3.0' , '< 6.0'

end
