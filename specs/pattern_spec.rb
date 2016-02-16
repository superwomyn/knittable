require './pattern'
require 'csv'
require 'pry'

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
      it 'raises' do
        pattern = Pattern.new
        pattern.data = [['']]
        expect{ pattern.generate }.to raise_error(RuntimeError)
      end
    end

    context 'when the data is one cell' do
      it 'returns the correct results array' do
        pattern = Pattern.new
        pattern.data = [['k']]
        expect(pattern.generate).to eq [[{:row=>0, :stitch=>"k", :stitch_count=>1}]]
      end
    end

    context 'when the data is one row of identical stitches' do
      it 'returns the correct results array' do
        pattern = Pattern.new
        pattern.data = [%w(k k k)]
        expect(pattern.generate).to eq [[{:row=>0, :stitch=>"k", :stitch_count=>3}]]
      end
    end

    # context 'when the data is one row of alternating stitches' do
    #   it 'returns the correct results array' do
    #     pattern = Pattern.new
    #     pattern.data = [%w(k p k)]
    #     expect(pattern.generate).to eq [[{:row=>0, :stitch=>"k", :stitch_count=>1},
    #                                      {:row=>0, :stitch=>"p", :stitch_count=>1},
    #                                      {:row=>0, :stitch=>"k", :stitch_count=>1}]]
    #   end
    # end
  end
end