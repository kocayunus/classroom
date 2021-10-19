boy = gets.chomp.to_i

puts "Boyunuz: #{boy + 5}"

exit

PRECISION = 4

puts 'Yola çıktık'

a, b, c = 1.0, 0.0, -1.0

delta = b ** 2 - 4 * a * c

if delta.round(PRECISION) >= 0.0
  delta_sqrt = Math.sqrt(delta)

  p, q = (-b - delta_sqrt) / 2 * a, (-b + delta_sqrt) / 2 * a

  puts "Kökler: (#{p}, #{q})"
else
  puts 'Çözüm yok'
end

puts 'Buradayız'

exit

string = ''

string << 'Cezmi'
string << ' '
string << 'Sahir'

puts string

exit

boy = gets.chomp.to_i

puts "Boyunuz: #{boy + 5}"
