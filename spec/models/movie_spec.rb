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
end
