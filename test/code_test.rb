require_relative 'test_helper'

require_relative '../lib/code.rb'

class TestClass < Test::Unit::TestCase
  class << self
    def startup
      puts "Getting page and storing in class for reuse"
      @@page = get_web_page('https://kat.cr/usearch/a%20pigeon%20sat%20on%20a%20branch%20reflecting%20on%20existence/')
    end

    def shutdown
    end

    def suite
      mysuite = super
      def mysuite.run(*args)
        TestClass.startup()
        super
        TestClass.shutdown()
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

  def test_pretty_print_page
    out = capture_stdout do
      pretty_print_page(@@page)
    end
    assert_not_nil out.string
  end

  def test_get_links
    out = capture_stdout do
      get_links(@@page.links)
    end
    assert_not_nil out.string
  end

  def test_search
    out = capture_stdout do
      result = @@page.search(".//tr[@class='even']")
      assert_not_nil result
    end
    assert_not_nil out.string
  end

  def test_download
    result = @@page.link_with(:href => 'http://torcache.net/torrent')
    puts "RESULTS2: ", result
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