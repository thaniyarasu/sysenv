require 'minitest/autorun'
require 'active_support'
require 'sysenv'


class SysenvTest < Minitest::Test

  def setup
    ENV["API_SECRET_KEY"] = "API_SECRET_VALUE" # system defined environment variables
    @env = {api:{secret:{key: 'value',cert:'certificate'}}}  # app defined environment variables
    @sysenv = Sysenv.new
  end
  
  def test_parse
    result = @sysenv.apply(@env)
    assert_equal result[:api][:secret][:key], ENV["API_SECRET_KEY"]
    assert_equal result[:api][:secret][:cert], 'certificate'
  end

  def test_override_nested_hash
    overrided_env = @sysenv.override_nested_hash(@env, { "api_secret_key": "API_SECRET_KEY"} )
    assert_equal overrided_env[:api][:secret][:key] , ENV["API_SECRET_KEY"] 
    assert_equal overrided_env[:api][:secret][:cert] , 'certificate' 
  end

end