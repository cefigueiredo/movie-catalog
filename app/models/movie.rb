require 'elasticsearch/model'

class Movie < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  acts_as_taggable_on :genres
  mapping do
    indexes :title
  end

  validates :title, presence: true

  def self.search2(text)
    self.__elasticsearch__.search({
      query: {
        fuzzy: {
          title: text
        }
      }
    })
  end

  def as_indexed_json(options = {})
    as_json(
      only: [
        :id, :title, :storyline, :release_date, :genre_list, :imdb_link
      ],
      methods: [:genre_list]
    )
  end
end
