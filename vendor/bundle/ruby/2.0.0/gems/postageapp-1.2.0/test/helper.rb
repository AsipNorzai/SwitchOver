require 'rubygems'

gem 'minitest'
require 'minitest/autorun'

gem 'minitest-reporters'
require 'minitest/reporters'

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

require 'fileutils'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'mail'

require 'postageapp'
require 'postageapp/mailer'

require 'mocha/setup'
require 'with_environment'

class MiniTest::Test
  include WithEnvironment

  def self.require_action_mailer(version)
    if (defined?(ActionMailer))
      if (ActionMailer::VERSION::MAJOR == version)
        return yield
      end
    end

    define_method(:test_skipped) do
      skip("Not testing against ActionMailer #{version}.x")
    end
  end

  def setup
    # Resetting to default configuration

    PostageApp.configure do |config|
      config.api_key = '1234567890abcdef'
      config.secure = true
      config.protocol = 'https'
      config.host = 'api.postageapp.com'
      config.port = 443
      config.proxy_host = nil
      config.proxy_port = nil
      config.proxy_user = nil
      config.proxy_pass = nil
      config.http_open_timeout = 5
      config.http_read_timeout  = 10
      config.recipient_override = nil
      config.requests_to_resend = %w( send_message )
      config.project_root = File.expand_path('../', __FILE__)
      config.environment = 'production'
      config.logger = nil
      config.framework = 'undefined framework'
    end

    if (defined?(ActionMailer))
      ActionMailer::Base.deliveries.clear
    end
  end
  
  def mock_successful_send(status = 'ok')
    Net::HTTP.any_instance.stubs(:post).returns(Net::HTTPResponse.new(nil, nil, nil))
    Net::HTTPResponse.any_instance.stubs(:body).returns({
      :response => { 
        :uid => 'sha1hashuid23456789012345678901234567890',
        :status => status
      },
      :data => {
        :message => { :id => 999 }
      }
    }.to_json)
  end
  
  def mock_failed_send
    Net::HTTP.any_instance.stubs(:post).returns(nil)
  end

  # Briefly substitutes a new object in place of an existing constant.
  def const_replace(name, object)
    original = Object.const_defined?(name) && Object.const_get(name)
    Object.send(:remove_const, name) if (original)
    Object.const_set(name, object)

    yield

  ensure
    Object.send(:remove_const, name)
    Object.const_set(name, original)
  end
end
