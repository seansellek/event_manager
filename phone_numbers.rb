require 'csv'

input_file = 'full_event_attendees.csv'
file = File.open(input_file, 'r:ISO-8859-1')
contents = CSV.parse(file, headers: true, header_converters: :symbol)

def clean_phone_number(raw_number)
  return 'Bad Number' unless verify_number?(raw_number)

  digits = raw_number.split('').select { |d| /\d/=~ d }
  digits.delete_at(0) if digits.length == 11

  digits.insert(0, '(')
  digits.insert(4, ')')
  digits.insert(5, ' ')
  digits.insert(9, '-')
  digits.join
end

def verify_number?(phone_number)
  digits = phone_number.split('')
  digits.select! { |d| /\d/=~ d }
  length = digits.length

  return false if length < 10
  return false if length > 11
  return false if length == 11 && digits[0] != '1'
  return true
end

contents.each do |row|
  name = row[:first_name]
  raw_phone_number = row[:homephone]
  phone_number = clean_phone_number(raw_phone_number)
  puts "#{name}: #{phone_number}"
end
