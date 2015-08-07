#!/usr/bin/ruby

def test_method(str)
	return str.upcase if str.respond_to?(:downcase)
end