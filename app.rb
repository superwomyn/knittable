require 'sinatra'
require 'sinatra/reloader' if development?
require 'csv'

get '/' do
  "Welcome to Knittable<br><br><form action='/pattern' method='post'><input type='file' name='csv_path'/><br><input type='submit'/></form>"
end

post '/pattern' do
  output = ''
  stitch = 'knit'
  color = 'white'
  stitch_count = 0
  previous_cell = 1
  row_count = 1
  image = ''
  CSV.foreach(params[:csv_path]) do |row|
    columns = row.to_a
    columns.each do |cell|
      if cell != previous_cell
        output = output + "<li>Row #{row_count}: #{stitch} #{stitch_count}</li>" unless stitch_count == 0
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
      image = image + "<div style='width:10px; height: 10px; display: inline-block; background-color: #{color};'>&nbsp;</div>"
      stitch_count += 1
    end
    output = output + "<li>Row #{row_count}: #{stitch} #{stitch_count}</li>" unless stitch_count == 0
    stitch = 'knit'
    stitch_count = 0
    previous_cell = 1
    row_count = row_count + 1
  end
  "<div style='max-width:400px'>#{image}</div><ul>#{output}</ul>"
end