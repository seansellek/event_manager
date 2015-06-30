require 'csv'

def weekday_string(day_index)
  case day_index
  when 0
    'Sunday'
  when 1
    'Monday'
  when 2
    'Tuesday'
  when 3
    'Wednesday'
  when 4
    'Thursday'
  when 5
    'Friday'
  when 6
    'Saturday'
  end
end
input_file = 'full_event_attendees.csv'
file = File.open(input_file, 'r:ISO-8859-1')
contents = CSV.parse(file, headers: true, header_converters: :symbol)
visiting_days = {}

contents.each do |row|
  date_string = row[:regdate]
  wday = DateTime.strptime(date_string, '%m/%d/%y %H:%M').wday
  visiting_days[wday] ||= 0
  visiting_days[wday] += 1
end
days = visiting_days.keys
days.sort_by! { |day| visiting_days[day] }
days.each do |day|
  puts "#{weekday_string(day)} => #{visiting_days[day]}" if visiting_days[day]
end
