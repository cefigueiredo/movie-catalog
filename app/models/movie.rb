require 'elasticsearch/model'

class Movie < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  acts_as_taggable_on :genres
  mapping do
    indexes :title
  end

  validates :title, presence: true

  def self.search(text)
    self.__elasticsearch__.search({
      query: {
        fuzzy: {
          title: text
        }
      }
    }).records
  end
end
