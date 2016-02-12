require './pattern'

RSpec.describe Pattern do
  describe "#generate" do

    context 'when there is no csv' do
      it "raises" do
        pattern = Pattern.new
        expect{ pattern.generate(nil) }.to raise_error(RuntimeError)
      end
    end

  end
end