require 'simplecov'
SimpleCov.add_filter 'vendor'
SimpleCov.add_filter 'test'
SimpleCov.command_name 'Unit tests'
SimpleCov.start
require 'test/unit'
require 'webmock'
WebMock.disable_net_connect!(:allow_localhost => true)
