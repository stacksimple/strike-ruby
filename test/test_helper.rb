$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "strike"

require "minitest/autorun"
require 'webmock/minitest'
require 'vcr'

ENV["STRIKE_API_KEY"] ||= "test_api_key_form_test_helper.rb"

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
  c.default_cassette_options = { :record => :once }
  c.allow_http_connections_when_no_cassette = true
end
