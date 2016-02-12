class Pattern

  attr_accessor :csv_path
  attr_accessor :data # multidimensional array of 1's and 0's

  def generate
    raise 'Path to CSV file or csv string is required' if @csv_path.nil? && @data.nil?
    @data = CSV.read(@csv_path) if @data.empty?
    results = []

    # output = ''
    stitch = 'knit'
    color = 'white'
    stitch_count = 0
    previous_cell = nil
    row_count = 0
    # image = ''
    column_count = 0
    @data.each do |row|
      # columns = row.to_a
      column_count = row.length
      row.each do |cell|
        # if we're changing from one stitch to another
        if cell != previous_cell && row_count != 0
          if results[row_count].nil?
            results[row_count] = [{row: row_count, stitch: stitch, stitch_count: stitch_count}] unless stitch_count == 0
          else
            results[row_count].push({row: row_count, stitch: stitch, stitch_count: stitch_count}) unless stitch_count == 0
          end
          if stitch == 'knit'
            color = 'blue'
            stitch = 'purl'
          else
            color = 'white'
            stitch = 'knit'
          end
          stitch_count = 0
          previous_cell = cell
        end

        # image = image + "<div style='width:10px; height: 10px; display: inline-block; background-color: #{color};'>&nbsp;</div>"
        stitch_count += 1
      end
      if results[row_count].nil?
        results[row_count] = [{row: row_count, stitch: stitch, stitch_count: stitch_count}] unless stitch_count == 0
      else
        results[row_count].push({row: row_count, stitch: stitch, stitch_count: stitch_count}) unless stitch_count == 0
      end
      stitch = 'knit'
      stitch_count = 0
      previous_cell = 1

      if row_count.odd?
        #reverse array
        results[row_count].reverse!
        results[row_count].each do |group|
          if group[:stitch] == 'knit'
            group[:stitch] = 'purl'
          else
            group[:stitch] = 'knit'
          end
        end
      end
      row_count = row_count + 1
    end
    results
  end
end