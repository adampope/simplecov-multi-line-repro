require 'test_helper'

class ThingTest < ActiveSupport::TestCase


  def test_coverage_of_foo
    assert_equal 1, Thing.new.foo[:a]
  end


end
