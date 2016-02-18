class Pattern

  attr_accessor :csv_path
  attr_accessor :data # multidimensional array of 1's and 0's

  def generate
    raise 'Path to CSV file or csv string is required' if @csv_path.nil? && @data.nil?
    @data = CSV.read(@csv_path) if @data.empty?

    raise 'CSV must contain at least one row populated with "1" or "0"' if @data.nil?

    output = ''
    stitch = 'k'
    stitch_count = 0
    previous_cell = 1
    row_count = 0
    column_count = 0
    results = []

    # foreach row
    @data.each_with_index do |row, i|
      columns = row.to_a
      column_count = columns.length

      # foreach column
      row.each_with_index do |cell, j|
        raise 'Cells must be populated with "1" or "0"' if cell != 1 && cell != 0

        # if we're changing from one stitch to another
        if cell != previous_cell
          if results[row_count].nil?
            results[row_count] = [{row: row_count, stitch: stitch, stitch_count: stitch_count}] unless stitch_count == 0
          else
            results[row_count].push({row: row_count, stitch: stitch, stitch_count: stitch_count}) unless stitch_count == 0
          end
          if stitch == 'k'
            stitch = 'p'
          else
            stitch = 'k'
          end
          stitch_count = 0
          previous_cell = cell
        end

        stitch_count += 1
      end
      if results[row_count].nil?
        results[row_count] = [{row: row_count, stitch: stitch, stitch_count: stitch_count}] unless stitch_count == 0
      else
        results[row_count].push({row: row_count, stitch: stitch, stitch_count: stitch_count}) unless stitch_count == 0
      end
      stitch = 'k'
      stitch_count = 0
      previous_cell = 1

      if row_count.odd?
        #reverse array
        results[row_count].reverse!
        results[row_count].each do |group|
          if group[:stitch] == 'k'
            group[:stitch] = 'p'
          else
            group[:stitch] = 'k'
          end
        end
      end
      row_count = row_count + 1
    end
    results
  end
end
