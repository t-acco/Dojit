require 'rails_helper'

describe Vote do
  
  describe "validations" do
    describe "#value validation" do
        
      before do
        @vote1 = Vote.new(value: 1)
        @vote2 = Vote.new(value: -1)
        @vote3 = Vote.new(value: 4)
      end

      it "only allows -1 or 1 as values" do

        expect(@vote1.valid?).to eq(true)
        expect(@vote2.valid?).to eq(true)
        expect(@vote3.valid?).to eq(false)
      end
    end
  end

  describe 'after_save' do
    it "calls `Post#update_rank` after save" do
      post = create(:post)
      vote = Vote.new(value: 1, post: post)
      expect(post).to receive(:update_rank)
      vote.save
    end
  end
end