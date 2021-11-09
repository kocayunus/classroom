# frozen_string_literal: true

cities_with_a = []

%w[samsun istanbul izmir adana].each do |city|
  cities_with_a << city if city.include? 'a'
end

puts cities_with_a

exit

found = nil # bu bir CLOSURE değişkeni

%w[samsun istanbul izmir adana].each do |city|
  next if city.include? 'a'

  found = city

  puts city
end

puts found

exit

%w[samsun istanbul izmir adana].each do |city|
  break unless city.include? 'a'

  puts city
end

puts '---'

%w[samsun istanbul izmir adana].each do |city|
  next if city.include? 'a'

  puts city
end

exit

cities = %w[
  adana
  bolu
  istanbul
  samsun
  zonguldak
]

i = 0
while i < cities.size
  puts "#{i + 1}. #{cities[i]}"
  i += 1
end

cities.each_with_index do |city, i|
  puts "#{i + 1}. #{city}"
end

