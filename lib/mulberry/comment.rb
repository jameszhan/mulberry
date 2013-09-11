module Comment
  class Comment < ::ActiveRecord::Base
    belongs_to :user
    belongs_to :commentable, :polymorphic => true

    attr_accessible :comment, :role, :title

    default_scope -> { order('created_at DESC') }

  end
end
