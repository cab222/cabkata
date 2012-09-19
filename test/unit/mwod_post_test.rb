require 'test_helper'

class MwodPostTest < ActiveSupport::TestCase
  test "validation" do
    post = MwodPost.new
    assert post.invalid?, "empty post must be invalid"
    assert post.errors[:title].any?, "empty post has errors"
    assert post.errors[:category].any?, "empty post has errors"
    assert post.errors[:description].any?, "empty post has errors"
    
    post.title = "title"
    post.save
        
    post1 = MwodPost.new;
    post1.title = "title";
    assert !post1.save
  end
end
