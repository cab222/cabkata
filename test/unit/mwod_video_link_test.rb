require 'test_helper'

class MwodVideoLinkTest < ActiveSupport::TestCase
  test "validation" do
    videoLink = MwodVideoLink.new
    assert videoLink.invalid?, "empty videoLink must be invalid"
    assert videoLink.errors[:link].any?, "empty videoLink link has errors"
  end
end
