require 'active_record'
module Mulberry
  autoload :Utils,          "mulberry/active_record/utils.rb"
  autoload :Tag,            "mulberry/active_record/tag.rb"
  autoload :Taggable,       "mulberry/active_record/taggable.rb"
  autoload :Tagging,        "mulberry/active_record/tagging.rb"
  autoload :Comment,        "mulberry/active_record/comment.rb"
  autoload :Commentable,    "mulberry/active_record/commentable.rb"
  autoload :Like,           "mulberry/active_record/like.rb"
  autoload :Likable,        "mulberry/active_record/likable.rb"
  autoload :Rate,           "mulberry/active_record/rate.rb"
  autoload :Ratable,        "mulberry/active_record/ratable.rb"
  autoload :Rating,         "mulberry/active_record/rating.rb"
  autoload :Vote,           "mulberry/active_record/vote.rb"
  autoload :Votable,        "mulberry/active_record/votable.rb"
  autoload :Catalog,        "mulberry/active_record/catalog.rb"
  autoload :Catalogable,    "mulberry/active_record/catalogable.rb"
  autoload :Relationship,   "mulberry/active_record/relationship.rb"
end

