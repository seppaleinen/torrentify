require_relative 'test_helper'
require_relative '../lib/menu.rb'

# Testing menu class
class TestMenuClass < Test::Unit::TestCase
  def test_run
    with_stdin do |user|
      user.puts 'HEJ'
      result = Menu.run
      assert_equal 'HEJ', result
    end
  end

  def with_stdin
    stdin = $stdin             # remember $stdin
    $stdin, write = IO.pipe    # create pipe assigning its "read end" to $stdin
    yield write                # pass pipe's "write end" to block
  ensure
    write.close                # close pipe
    $stdin = stdin             # restore $stdin
  end
end
