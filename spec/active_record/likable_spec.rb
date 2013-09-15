require 'spec_helper'
describe Mulberry::Taggable do
  
  before(:all) do
    User.class_eval do
      include Mulberry::Likable
    end 
  end
  
  context "check like functionalities" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    
    it "user1 like user2" do
      user2.likes_value.should == 0
      user1.like(user2)
      user1.like?(user2).should be_true
      user1.dislike?(user2).should be_false
      user2.likes_value.should == 1
      user1.users_who_liked.should be_empty
      user2.users_who_liked.should == [user1]
    end
    
    it "user1 unlike user2" do      
      user1.unlike(user2)
      user2.likes_value.should == 0
      user1.like?(user2).should be_false
      
      user1.like(user2)
      user1.unlike(user2)      
      user1.like?(user2).should be_false
      user2.likes_value.should == 0
      user1.users_who_liked.should be_empty
      user2.users_who_liked.should be_empty
    end
    
    it "user1 dislike user2" do      
      user1.dislike(user2)      
      user1.dislike?(user2).should be_true
      user1.like?(user2).should be_false
      user2.likes_value.should == -1
      user1.users_who_liked.should be_empty
      user2.users_who_liked.should == [user1]
    end
    
    it "like and then dislike" do      
      user1.like(user2)  
      user1.dislike(user2)      
      user1.dislike?(user2).should be_false
      user1.like?(user2).should be_false
      user2.likes_value.should == 0
      user1.users_who_liked.should be_empty
      user2.users_who_liked.should be_empty
    end
    
    it "dislike and then like" do  
      user1.dislike(user2)         
      user1.like(user2)      
      user1.dislike?(user2).should be_false
      user1.like?(user2).should be_false
      user2.likes_value.should == 0
      user1.users_who_liked.should be_empty
      user2.users_who_liked.should be_empty
    end
  end
  
end
