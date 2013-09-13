module Mulberry
  module Votable
    extend ::ActiveSupport::Concern
    include Utils

    included do
      has_many :votes, as: :votable, class_name: "Mulberry::Vote"
      scope :voted_by, ->(user){ joins(:votes)
        .where(votes: {user_id: user, votable_type: class_of_active_record_descendant(self)})
        .order("created_at DESC") }
        
      user_class.class_eval do        
        def vote_on(votable)
          votable.votes.find_or_initialize_by(user: self).value.to_i
        end
        
        def voted?(votable)
          votable.votes.where(user_id: self).any?
        end
        
        def up?(votable)
          votable.votes.where(user: self).first.try(:value).to_i > 0
        end

        def down?(votable)
          votable.votes.where(user: self).first.try(:value).to_i < 0
        end

        def up(votable)
          votable.do_vote(1, self)
        end

        def down(votable)
          votable.do_vote(-1, self)
        end        
      end
    end 
    
    def votes_value
      votes.sum(:value)
    end
    
    # upsert
    def do_vote(value, user)
      vote = votes.find_or_initialize_by(user: user)
      if value == 0
        vote.delete
      else
        vote.value = value
        vote.save
      end
    end
    
  end
end
