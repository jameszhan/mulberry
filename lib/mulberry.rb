require "mulberry/version"

module Mulberry
  autoload :Utils,      "mulberry/utils.rb"
  autoload :Tag,        "mulberry/tag.rb"
  autoload :Taggable,   "mulberry/taggable.rb"
  autoload :Tagging,    "mulberry/tagging.rb"
  autoload :Comment,    "mulberry/comment.rb"
  autoload :Commentable,"mulberry/commentable.rb"
  autoload :Like,       "mulberry/like.rb"
  autoload :Likable,    "mulberry/likable.rb"
  autoload :Rate,       "mulberry/rate.rb"
  autoload :Ratable,    "mulberry/ratable.rb"
  autoload :Rating,     "mulberry/rating.rb"
end
