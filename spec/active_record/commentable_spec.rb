require 'spec_helper'
describe Mulberry::Commentable do
  
  before(:all) do
    Mulberry::Catalog.class_eval do
      include Mulberry::Commentable
    end 
  end
  
  context "check rate functionalities" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let(:ruby) { create(:ruby) }
    let(:java) { create(:java) }
    
    it :comment! do
      ruby.comment!("It's good for me.", user1)
      ruby.comments.first.content.should == "It's good for me."
      ruby.comments.first.user.should == user1
    end
  
    it :commented_by? do
      ruby.comment!("It's good for me.", user1)
      ruby.commented_by?(user1).should be_true
      ruby.commented_by?(user2).should be_false
    end
    
    it :commented_by do
      ruby.comment!("It's good for me.", user1)
      java.comment!("It's good for me.", user1)
      Mulberry::Catalog.commented_by(user1).should == [ruby, java]
      Mulberry::Catalog.commented_by(user2).should be_empty
    end
    
    it :find_comments_by do
      ruby.comment!("It's good for me.", user1)
      java.comment!("It's good for me.", user1)
      comments = Mulberry::Catalog.find_comments_by(user1)
      comments.each{|comment| comment.content.should == "It's good for me."}
      Mulberry::Catalog.find_comments_by(user3).should be_empty
    end
    
  end
  
end
