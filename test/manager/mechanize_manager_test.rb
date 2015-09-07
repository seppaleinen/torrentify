require_relative '../test_helper'

require_relative '../../lib/manager/mechanize_manager'

# Tests for code
class TestMechanizeManagerClass < Test::Unit::TestCase
  class << self
    def startup
      puts 'Getting page and storing in class for reuse'
      begin
        search_term = 'a pigeon sat on a branch reflecting on existence'
        @@page = MechanizeManager.new.search_kickass(search_term)
      rescue ResponseCodeError
        puts 'error getting page'
      end
    end

    def shutdown
    end

    def suite
      mysuite = super
      def mysuite.run(*args)
        TestMechanizeManagerClass.startup
        super
        TestMechanizeManagerClass.shutdown
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
