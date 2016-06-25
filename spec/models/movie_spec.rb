require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:model) { Movie.new title: "Any title" }

  describe "validations" do
    it { expect(model.valid?).to be_truthy }

    it "validates presence of :title" do
      model.title = nil

      expect(model.valid?).to be_falsy
    end
  end

  describe "#genres" do
    let(:tag1) { ActsAsTaggableOn::Tag.create(name: "tag1") }
    let(:tag2) { ActsAsTaggableOn::Tag.create(name: "tag2") }

    it "lists genres tags" do
      model.genre_list = "tag1, tag2"
      model.save
      model.reload

      expect(model.genres).to include(tag1)
      expect(model.genres).to include(tag2)
    end
  end

  describe ".search" do
    let(:elasticsearch) { double("ElasticSearch::Model::Proxy") }

    before do
      allow(Movie).to receive(:__elasticsearch__).and_return(elasticsearch)
      allow(elasticsearch).to receive(:search)
    end

    it "call __elasticsearch__ search" do
      Movie.search("Some title")

      expect(elasticsearch).to have_received(:search).with(
        {query: {fuzzy: {title: "Some title"} } }
      )
    end
  end
end
