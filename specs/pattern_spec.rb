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
        pattern.data = nil
        expect{ pattern.generate }.to raise_error(RuntimeError)
      end
    end

    context 'when the data is unsupported' do
      it 'raises' do
        pattern = Pattern.new
        pattern.data = [['ASDF']]
        expect{ pattern.generate }.to raise_error(RuntimeError)
      end
    end

    context 'when the data is one cell' do
      it 'returns the correct results array' do
        pattern = Pattern.new
        pattern.data = [[0]]
        expect(pattern.generate).to eq [[{:row=>0, :stitch=>"p", :stitch_count=>1}]]
      end
    end

    context 'when the data is one row of identical stitches' do
      it 'returns the correct results array' do
        pattern = Pattern.new
        pattern.data = [[0, 0, 0]]
        expect(pattern.generate).to eq [[{:row=>0, :stitch=>"p", :stitch_count=>3}]]
      end
    end

    context 'when the data is one row of alternating stitches' do
      it 'returns the correct results array' do
        pattern = Pattern.new
        pattern.data = [[0, 1, 0]]
        expect(pattern.generate).to eq [[{:row=>0, :stitch=>"p", :stitch_count=>1},
                                         {:row=>0, :stitch=>"k", :stitch_count=>1},
                                         {:row=>0, :stitch=>"p", :stitch_count=>1}]]
      end
    end

    context 'when the data is two rows of identical stitches' do
      it 'returns the correct results array' do
        pattern = Pattern.new
        pattern.data = [[1, 1, 1], [1, 1, 1]]
        expect(pattern.generate).to eq [[{:row=>0, :stitch=>"k", :stitch_count=>3}],
                                         [{:row=>1, :stitch=>"p", :stitch_count=>3}]]
      end
    end

    context 'when the data is two rows of alternating stitches' do
      it 'returns the correct results array' do
        pattern = Pattern.new
        pattern.data = [[1, 1, 1], [0, 0, 0]]
        expect(pattern.generate).to eq [[{:row=>0, :stitch=>"k", :stitch_count=>3}],
                                        [{:row=>1, :stitch=>"k", :stitch_count=>3}]]
      end
    end
  end
end