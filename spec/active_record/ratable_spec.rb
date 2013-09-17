require 'spec_helper'
describe Mulberry::Ratable do
  
  before(:all) do
    Mulberry::Catalog.class_eval do
      include Mulberry::Ratable
    end 
  end
  
  context "check rate functionalities" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let(:ruby) { create(:ruby) }
    let(:java) { create(:java) }
    
    it "rate by users" do
      ruby.rate!(3, user1)
      ruby.rate!(2, user2)
      ruby.rate!(1, user3)   
      ruby.rate.should == 2
    end
    
    it "rate by same user" do
      ruby.rate!(3, user1)
      ruby.rate.should == 3
      ruby.rate!(2, user1)
      ruby.rate.should == 2
      ruby.rate!(1, user1)   
      ruby.rate.should == 1
    end
    
    it "rate by user & ip" do
      ruby.rate!(3, user1)
      ruby.rate.should == 3
      ruby.rate!(2, id: '127.0.0.1', type: "IP")
      ruby.rate.should == 2.5
    end
    
    it "find users who rated " do
      ruby.rate!(2, user1)
      java.rate!(3, user3)
      ruby.rate!(2, user3)
      Mulberry::Catalog.rated_by(user1).should == [ruby]
      Mulberry::Catalog.rated_by(user2).should be_empty
      Mulberry::Catalog.rated_by(user3).should == [java, ruby]
    end
    
    it "rated_by?" do
      ruby.rate!(2, user1)
      ruby.rate!(2, user3)
      ruby.rated_by?(user1).should be_true
      ruby.rated_by?(user2).should be_false
      ruby.rated_by?(user3).should be_true
    end
    
  end
  
end
