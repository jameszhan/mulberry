module Mulberry
  module Commentable
    extend ::ActiveSupport::Concern

    included do
      class_eval do
        has_many :comments, :as => :commentable, :dependent => :destroy
      end
    end

    def comment_by(user, comment)
      comments.create(:user => user, :comment => comment)
    end  

    def comment_by_user?(user)
      user = current_user unless user
      user && comments.first(:conditions => {:user_id => user})
    end

    module ClassMethods
      def find_comments_by_user(user)
        commentable = self.base_class.name.to_s
        Comment.where(:user_id => user.id, :commentable_type => commentable).order('created_at DESC')
      end    
    end

  end
end
