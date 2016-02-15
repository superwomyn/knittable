class Pattern

  attr_accessor :csv_path
  attr_accessor :data # multidimensional array of 1's and 0's

  def generate
    raise 'Path to CSV file or csv string is required' if @csv_path.nil? && @data.nil?
    @data = CSV.read(@csv_path) if @data.empty?

    results = []
    stitch = 'k'
    stitch_count = 0

    # foreach row
    @data.each_with_index do |row, i|
      max_columns = row.length

      # foreach column
      row.each_with_index do |cell, j|
        raise 'Cells must be populated with "k" (Knit) or "p" (Purl)' if cell != 'k' && cell != 'p'
        stitch_count += 1

        binding.pry
        # write to results array
        results[i] = [{row: i, stitch: stitch, stitch_count: stitch_count}] if last?(j, max_columns)

      end
    end
    results
  end

  def last?(count, max)
    count == max - 1
  end


end
