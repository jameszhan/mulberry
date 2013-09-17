require 'spec_helper'
describe Mulberry::Likable do
  
  before(:all) do
    Mulberry::Catalog.class_eval do
      include Mulberry::Likable
    end 
  end
  
  context "check like functionalities" do
    let(:user) { create(:user) }
    let(:ruby) { create(:ruby) }
    
    it "user like ruby" do
      ruby.likes_value.should == 0
      user.like(ruby)
      user.like?(ruby).should be_true
      user.dislike?(ruby).should be_false
      ruby.likes_value.should == 1
      ruby.users_who_liked.should == [user]
    end
    
    it "user unlike ruby" do      
      user.unlike(ruby)
      ruby.likes_value.should == 0
      user.like?(ruby).should be_false
      
      user.like(ruby)
      user.unlike(ruby)      
      user.like?(ruby).should be_false
      ruby.likes_value.should == 0
      ruby.users_who_liked.should be_empty
    end
    
    it "user dislike ruby" do      
      user.dislike(ruby)      
      user.dislike?(ruby).should be_true
      user.like?(ruby).should be_false
      ruby.likes_value.should == -1
      ruby.users_who_liked.should == [user]
    end
    
    it "like and then dislike" do      
      user.like(ruby)  
      user.dislike(ruby)      
      user.dislike?(ruby).should be_false
      user.like?(ruby).should be_false
      ruby.likes_value.should == 0
      ruby.users_who_liked.should be_empty
    end
    
    it "dislike and then like" do  
      user.dislike(ruby)         
      user.like(ruby)      
      user.dislike?(ruby).should be_false
      user.like?(ruby).should be_false
      ruby.likes_value.should == 0
      ruby.users_who_liked.should be_empty
    end
  end
  
end
