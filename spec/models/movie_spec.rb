require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe "validations" do
    let(:model) { Movie.new title: "Any title" }

    it { expect(model.valid?).to be_truthy }

    it "validates presence of :title" do
      model.title = nil

      expect(model.valid?).to be_falsy
    end
  end
end
