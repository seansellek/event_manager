require 'csv'


input_file = 'event_attendees.csv'
contents = CSV.open(input_file, headers: true, header_converters: :symbol)

visiting_hours = {}

contents.each do |row|
  date_string = row[:regdate]
  hour = DateTime.strptime(date_string, '%m/%d/%y %H:%M').hour
  visiting_hours[hour] ||= 0
  visiting_hours[hour] += 1
end
hours = visiting_hours.keys
hours.sort_by! {|hour| visiting_hours[hour] }
hours.each do |hour|
  puts "#{hour}:00-#{hour}:59 => #{visiting_hours[hour]}" if visiting_hours[hour]
end
