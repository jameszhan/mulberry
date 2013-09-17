module Mulberry
  module Commentable
    extend ::ActiveSupport::Concern
    include Utils

    included do
      has_many :comments, as: :commentable, dependent: :destroy, class_name: "Mulberry::Comment"
      
      scope :commented_by, ->(user){ joins(:comments)
        .where(comments: {user_id: user, commentable_type: class_of_active_record_descendant(self)})
      }
      scope :find_comments_by, ->(user){ Comment.where(user_id: user, commentable_type: class_of_active_record_descendant(self)).order('created_at DESC') }
    end

    def comment!(content, user, title = nil)
      comments.create(user: user, title: title, content: content)
    end  

    def commented_by?(user)
      comments.where(user_id: user).any?
    end

  end
end
