require 'spec_helper'

describe "PostCreations" do
  describe "GET /mwod_posts" do
    it "it gets some mwod post" do
      FactoryGirl.create(:mwod_post)
      visit mwod_posts_path
      page.should have_content("All about ankles")
    end
  end
  
  describe "GET /mwod_posts/new" do
    it "creates a new mwod post without filling the form", :js => true do
      FactoryGirl.create(:mwod_post)
      visit mwod_posts_path
      click_link "New Mwod post"
      click_button "Create Mwod post"  
      page.should have_content("prohibited this MWOD Post from being saved")
      page.should have_content("Title can't be blank")
      fill_in "Title", :with => "This post is about feet"
      fill_in "Category", :with => "Blog"
      fill_in "Description", :with => "Really, this post is all about feet"
      click_button "Create Mwod post" 
      page.should have_content("4 errors prohibited")    
      click_link "add link" 
      #fill_in "tag label", :with => "http://www.youtube.com"
      click_link "add tag"
      #fill_in "tag", :with => "sample tag"
    end
  end
  
  describe "GET /mwod_posts validate response code" do
    it "it gets some mwod post" do
      FactoryGirl.create(:mwod_post)
      get mwod_posts_path
      response.status.should be(200)
    end
  end
end
