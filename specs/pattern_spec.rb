require './pattern'
require 'csv'

RSpec.describe Pattern do
  describe "#generate" do

    context 'when there is no data or csv path provided' do
      it 'raises' do
        pattern = Pattern.new
        expect{ pattern.generate }.to raise_error(RuntimeError)
      end
    end

    # TODO FIXME create an actual csv file with data
    # context 'when there is a csv file provided' do
    #   it 'uses the csv file to populate the data' do
    #     pattern = Pattern.new
    #     pattern.csv_path = 'test.csv'
    #     expect{ pattern.generate }.to raise_error(RuntimeError)
    #   end
    # end

    context 'when the data is empty' do
      it 'returns the correct results array' do
        pattern = Pattern.new
        pattern.data = [['']]
        expect(pattern.generate).to eq [['']] # TODO FIXME this is actually wrong
      end
    end

    context 'when the data is one cell' do
      it 'returns the correct results array' do
        pattern = Pattern.new
        pattern.data = [['1']]
        expect(pattern.generate).to eq [['1']]
      end
    end

  end
end