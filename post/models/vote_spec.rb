describe Vote do
  describe "validations" do
    describe "value validation" do
        
      before do
        @vote1 = Vote.new(value: 1)
        @vote2 = Vote.new(value: -1)
        @vote3 = Vote.new(value: 4)
      end

      it "only allows -1 or 1 as values" do

        expected(@vote1.valid?).to eq(true)
        expected(@vote2.valid?).to eq(true)
        expected(@vote3.valid?).to eq(false)
      end
    end
  end
end