require 'spec_helper'
describe Mulberry::Votable do
  
  before(:all) do
    Mulberry::Catalog.class_eval do
      include Mulberry::Votable
    end 
  end
  
  context "check rate functionalities" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let(:ruby) { create(:ruby) }
    let(:java) { create(:java) }
    
    it :up do
      user1.up(ruby)
      ruby.votes_value.should == 1
      user1.up(ruby)
      ruby.votes_value.should == 1
      user2.up(ruby)
      ruby.votes_value.should == 2
    end
  
    it :down do
      user1.down(ruby)
      ruby.votes_value.should == -1
      user1.down(ruby)
      ruby.votes_value.should == -1
      user2.down(ruby)
      ruby.votes_value.should == -2
    end
    
    it :up? do
      user1.up(ruby)
      user1.up?(ruby).should be_true
      user1.down(ruby)
      user1.up?(ruby).should be_false
      user1.down(ruby)
      user1.up?(ruby).should be_false
    end
    
    it :down? do
      user1.up(ruby)
      user1.down?(ruby).should be_false
      user1.down(ruby)
      user1.down?(ruby).should be_true
      user1.down(ruby)
      user1.down?(ruby).should be_true
    end
    
    it :voted? do
      user1.up(ruby)
      user1.voted?(ruby).should be_true
      user1.down(ruby)
      user1.voted?(ruby).should be_true
      user2.down(ruby)
      user2.voted?(ruby).should be_true
    end
    
    it :vote_on do

    end
    
  end
  
end