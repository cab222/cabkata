require 'test_helper'

class MwodVideoLinkTest < ActiveSupport::TestCase
  test "validation" do
    videoLink = MwodVideoLink.new
    assert videoLink.invalid?, "empty videoLink must be invalid"
  end
end
