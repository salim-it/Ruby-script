require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'


def clean_zipcodes(zipcode)

	if zipcode.class == NilClass
		zipcode = '00000'
	elsif zipcode.length > 5
		zipcode = zipcode[0,5]
	elsif zipcode.length < 5
		zipcode = "%05d" % zipcode
	else
		zipcode
	end
end

def legislators_by_zipcode(zipcode)
	civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
	civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

	begin
	legislators = civic_info.representative_info_by_address(
	address: zipcode,
	levels: 'country',
	roles: ['legislatorUpperBody', 'legislatorLowerBody'],
	
	).officials
	rescue
		'You can find your legislators at www.commoncause.org/take-action/find-elected-officials'
	end

end

def thank_you(id, form_letter)
	Dir.mkdir('output') unless Dir.exist?('output')
	filename = "output/thanks #{id}.html"
	File.open(filename, 'w') do |file|
		file.puts form_letter
	end
end

def phone_cleanup(number)	
	phone = number.to_s.gsub(/[^0-9]/, '').lstrip
	if phone.length < 10 || phone.length > 11
		phone = "bad number"
	elsif phone.length == 11 && phone[0] == "1"
		phone[0] = ''
	elsif phone.length == 11 && phone[0] != "1"
		phone = "bad number"
	else
		phone
	end
	phone
end

def day_cleanup_and_count(regdate, count_days)
	date = regdate.split(" ")[0].split('/')
	date = Date.new("#{'20' << date[2]}".to_i,date[0].to_i,date[1].to_i)
	date = date.strftime('%a')
	count_days[date] += 1
	date
end

def hour_count(regdate, count_time)
	hours = regdate.split(" ")[1].split("\:")[0]
	count_time[hours] += 1
	hours
end

puts 'Event Manager Initialized'
puts ''
contents = CSV.open(
	'event_attendees.csv',
	headers: true,
	header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter
count_time = Hash.new(0)
count_days = Hash.new(0)

contents.each do |row|
	id = row[0]
	name = row[:first_name].lstrip
	zipcode = row[:zipcode]
	phone = row[:homephone]
	regdate = row[:regdate]
	zipcode = clean_zipcodes(zipcode)
	legislators = legislators_by_zipcode(zipcode)
	form_letter = erb_template.result(binding)
	thank_you(id, form_letter)
	phone = phone_cleanup(phone)
	date = day_cleanup_and_count(regdate, count_days)	
	hours = hour_count(regdate, count_time)
	puts "#{name}	#{phone} #{date} #{hours << "\:00"}"
end
puts "\nRegister hours and how many users\n\n"
puts "#{count_time.sort_by {|time, usercount| usercount * -1}}"

puts "\nDays when most customers register\n\n"
puts "#{count_days.sort_by {|day, count| count * -1}}\n"
