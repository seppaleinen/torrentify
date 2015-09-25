require 'simplecov'
SimpleCov.add_filter 'vendor'
SimpleCov.add_filter 'test'
SimpleCov.command_name 'Unit tests'
SimpleCov.start
require 'test/unit'
require 'webmock/test_unit'
WebMock.disable_net_connect!(:allow_localhost => true)
