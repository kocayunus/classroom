# frozen_string_literal: true

a = %w[foo barrr he]

b = a.sort do |a, b|
  a.length <=> b.length
end

b = a.sort_by { |e| e.length }

puts b

exit

a = [1, 2, 3, 4, 5]

puts "Kareler"
puts a.map { |e| e * e }

exit

a = [1, 2, 3, 4, 5]

b = []

a.each { |e| b << e * e }

puts "Kareler"
puts b

exit

a = [1, 2, 3, 4, 5]

puts "Çiftler"
puts a.filter { |e| e.even? }
# puts a.select(&:even?)

exit

a = [1, 2, 3, 4, 5]

b = []

a.each { |e| b << e if e.even? }

puts "Çiftler"
puts b


