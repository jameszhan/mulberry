require 'spec_helper'
describe Mulberry::Taggable do
  
  before(:all) do
    User.class_eval do
      include Mulberry::Taggable
    end 
  end
  
  context "search with unexisting tags" do
    let!(:user) { FactoryGirl.create(:user) }
    it "will be empty for every search" do
      User.tagged_with("X", "Y").should be_empty
      User.tagged_with("X", "Y", any: true).should be_empty
      User.tagged_with("X", "Y", match_all: true).should be_empty
      User.tagged_with("X", "Y", exclude: true).should be_empty
    end
  end
  
  context "check tagged_with without group" do
    before(:all) { Mulberry::Tag.find_or_create_by(name: 'A') }
    let!(:user1) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }
    let!(:user3) { FactoryGirl.create(:user) }
    let!(:user4) { FactoryGirl.create(:user) }
    let!(:user5) { FactoryGirl.create(:user) }
    it "should be empty" do
      User.tagged_with("A", "B", "C").should be_empty
      User.tagged_with("A", "B", "C", any: true).should be_empty
      User.tagged_with("A", "B", "C", match_all: true).should be_empty
      User.tagged_with("A", "B", "C", exclude: true).should_not be_empty  
    end
    it "tagged_with without group" do
      user1.tag('A', 'B')
      user2.tag('A', 'B', 'C')
      user3.tag('B', 'C', 'D')
      User.tagged_with("A").should == [user1, user2]
      User.tagged_with("A", "B").should == [user1, user2]
      User.tagged_with("A", "B", "C").should == [user2]
      User.tagged_with("A", "B", "C", any: true).should == [user1, user2, user3]
      User.tagged_with("A", match_all: true).should be_empty
      User.tagged_with("A", "B", match_all: true).should == [user1]
      User.tagged_with("A", "B", "C", match_all: true).should == [user2]
      User.tagged_with("C", "D", exclude: true).should == [user1, user4, user5]
      User.tagged_with("A", "B", exclude: true).should == [user4, user5]
    end
  end
  
  context "check tagged_with with group" do 
    let(:group) { "james" }
    before(:all) { Mulberry::Tag.find_or_create_by(name: 'A', group: group) }   
    let!(:user1) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }
    let!(:user3) { FactoryGirl.create(:user) }
    let!(:user4) { FactoryGirl.create(:user) }
    let!(:user5) { FactoryGirl.create(:user) }
    it "should be empty" do
      User.tagged_with("A", "B", "C", group: group).should be_empty
      User.tagged_with("A", "B", "C", any: true, group: group).should be_empty
      User.tagged_with("A", "B", "C", match_all: true, group: group).should be_empty
      User.tagged_with("A", "B", "C", exclude: true, group: group).should_not be_empty  
    end

    it "tagged_with with group" do
      user1.tag('A', 'B', group: group)
      user2.tag('A', 'B', 'C', group: group)
      user3.tag('B', 'C', 'D', group: group)
      User.tagged_with("A", group: group).should == [user1, user2]
      User.tagged_with("A", "B", group: group).should == [user1, user2]
      User.tagged_with("A", "B", "C", group: group).should == [user2]
      User.tagged_with("A", "B", "C", any: true, group: group).should == [user1, user2, user3]
      User.tagged_with("A", match_all: true, group: group).should be_empty
      User.tagged_with("A", "B", match_all: true, group: group).should == [user1]
      User.tagged_with("A", "B", "C", match_all: true, group: group).should == [user2]
      User.tagged_with("C", "D", exclude: true, group: group).should == [user1, user4, user5]
      User.tagged_with("A", "B", exclude: true, group: group).should == [user4, user5]
    end
  end
  
  context "update tags" do
    let(:user) { FactoryGirl.create(:user) }
    it "just add new tags" do
      user.tag('A', 'B', 'C')
      user.tags.map(&:name).should == ['A', 'B', 'C']
      user.tag('B', 'C', 'D')
      user.tags.map(&:name).should == ['A', 'B', 'C', 'D']
    end
    it "will override the origial tags" do
      user.tag('A', 'B', 'C')
      user.tags.map(&:name).should == ['A', 'B', 'C']
      user.tag('B', 'C', 'D', force: true)
      user.tags.map(&:name).should == ['B', 'C', 'D']
    end
  end
  
end
