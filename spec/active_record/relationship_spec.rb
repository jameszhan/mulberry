require 'spec_helper'
describe Mulberry::Relationship do
  
  before(:all) do
    User.class_eval do
      include Mulberry::Relationship
    end
  end
  
  context "check empty relationship" do
    let(:user) { FactoryGirl.create(:user) }
    it "check followers & followees" do
      user.followers.should be_empty
      user.followees.should be_empty
    end
  end
  
  context "check follow and unfollow" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    it "can follow and unfollow" do
      user1.follow?(user2).should be_false
      user2.followed_by?(user1).should be_false
      
      user1.follow(user2)
      user1.followees.should include(user2)
      user2.followers.should include(user1)
      
      user1.follow?(user2).should be_true
      user2.followed_by?(user1).should be_true
      
      user1.unfollow(user2)
      user1.followees.should_not include(user2)
      user2.followers.should_not include(user1)
      
      user1.follow?(user2).should be_false
      user2.followed_by?(user1).should be_false
    end
  end
  
  context "check friendship" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    it "can make friend with each other" do
      user1.make_friend_with(user2)
      user1.friend_with?(user2).should be_true
      user2.friend_with?(user1).should be_true
    end
  end


end

