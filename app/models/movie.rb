class Movie < ActiveRecord::Base
  acts_as_taggable_on :genres

  validates :title, presence: true
end
