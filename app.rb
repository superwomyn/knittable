require 'sinatra'
require 'sass'
require 'sinatra/reloader' if development?
require 'csv'

get '/stylesheets/:stylesheet.css' do |stylesheet|
  scss :"stylesheets/#{stylesheet}"
end

get '/' do
  erb :index
end

post '/pattern' do
  output = ''
  stitch = 'knit'
  color = 'white'
  stitch_count = 0
  previous_cell = 1
  row_count = 0
  image = ''
  column_count = 0
  results = []
  CSV.foreach("csv/#{params[:csv_path]}") do |row|
    columns = row.to_a
    column_count = columns.length
    columns.each do |cell|
      # if we're changing from one stitch to another
      if cell != previous_cell
        if results[row_count].nil?
          results[row_count] = [{ row: row_count, stitch: stitch, stitch_count: stitch_count }] unless stitch_count == 0
        else
          results[row_count].push(row: row_count, stitch: stitch, stitch_count: stitch_count) unless stitch_count == 0
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

      image += "<div style='width:10px; height: 10px; display: inline-block; background-color: #{color};'>&nbsp;</div>"
      stitch_count += 1
    end
    if results[row_count].nil?
      results[row_count] = [{ row: row_count, stitch: stitch, stitch_count: stitch_count }] unless stitch_count == 0
    else
      results[row_count].push(row: row_count, stitch: stitch, stitch_count: stitch_count) unless stitch_count == 0
    end
    stitch = 'knit'
    stitch_count = 0
    previous_cell = 1

    if row_count.odd?
      # reverse array
      results[row_count].reverse!
      results[row_count].each do |group|
        group[:stitch] = if group[:stitch] == 'knit'
                           'purl'
                         else
                           'knit'
                         end
      end
    end
    row_count += 1
  end

  erb :pattern, locals: { results: results, image: image }
end
