require_relative 'test_helper'

require_relative '../lib/mechanize_manager.rb'

# Tests for code
class TestClass < Test::Unit::TestCase
  class << self
    def startup
      puts 'Getting page and storing in class for reuse'
      begin
        @@page = MechanizeManager.new.get_web_page('https://kat.cr/usearch/a%20pigeon%20sat%20on%20a%20branch%20reflecting%20on%20existence/')
      rescue ResponseCodeError
        puts 'error getting page'
      end
    end

    def shutdown
    end

    def suite
      mysuite = super
      def mysuite.run(*args)
        TestClass.startup
        super
        TestClass.shutdown
      end
      mysuite
    end
  end

  def setup
    puts 'runs before each test'
  end

  def teardown
    puts 'runs after each test'
  end

  def test_get_web_page_kickass
    assert_not_nil @@page
  end
end

# Capture of stdout to STDOUT var
module Kernel
  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    return out
  ensure
    $stdout = STDOUT
  end
end
