require 'test_helper'

class MwodTagTest < ActiveSupport::TestCase
  test "validation" do
    tag = MwodTag.new
    assert tag.invalid?, "empty tag must be invalid"
  end
end
