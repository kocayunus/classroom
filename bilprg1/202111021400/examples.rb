# frozen_string_literal: true

DEFAULT_UPPER = 100
DEFAULT_TRIES = 5

def guess(upper:, tries:)
  upper ||= DEFAULT_UPPER
  tries ||= DEFAULT_TRIES

  # puts "upper: #{upper} tries: #{tries}"; exit

  number = rand(upper) + 1

  try = 0

  loop do
    if try >= tries
      puts 'Üzgünüm, maksimum tahmin hakkını kullandınız!'
      puts "Tahmin etmeniz gereken sayı #{number} idi."
      break
    end

    try += 1

    print "1-#{upper} arasında bir sayı [deneme #{try}/#{tries}]? "
    guess = STDIN.gets.chomp.to_i

    if guess == number
      puts 'Bravo bildiniz!'
      break
    elsif guess > number
      puts 'Daha küçük'
    else
      puts 'Daha büyük'
    end
  end

  puts 'Yeni tahminlerde buluşmak üzere'
end

def main
  guess upper: ARGV[0]&.to_i, tries: ARGV[1]&.to_i
end

UPPER = 100
TRIES = 5

def main4
  upper  = UPPER
  tries  = TRIES
  number = rand(upper) + 1

  try = 0

  loop do
    if try >= tries
      puts 'Üzgünüm, maksimum tahmin hakkını kullandınız!'
      puts "Tahmin etmeniz gereken sayı #{number} idi."
      break
    end

    try += 1

    print "1-#{upper} arasında bir sayı [deneme #{try}/#{tries}]? "
    guess = gets.chomp.to_i

    if guess == number
      puts 'Bravo bildiniz!'
      break
    elsif guess > number
      puts 'Daha küçük'
    else
      puts 'Daha büyük'
    end
  end

  puts 'Yeni tahminlerde buluşmak üzere'
end

def main3
  number = rand(100) + 1

  loop do
    print 'Tahmin? '
    guess = gets.chomp.to_i

    if guess == number
      puts 'Başardınız!'
      break
    elsif guess > number
      puts 'Daha küçük'
    else
      puts 'Daha büyük'
    end
  end

  puts 'Bizi denediğiniz için teşekkürler!'
end

def main2
  number = rand(5) + 1

  loop do
    print 'Tahmin? '
    guess = gets.chomp.to_i

    if number == guess
      puts 'Başardınız!'
      break
    else
      puts 'Hatalı tahmin; lütfen tekrar deneyin!'
    end
  end

  puts 'Bizi denediğiniz için teşekkürler!'
end

def main1
  number = rand(5) + 1

  while true
    print 'Tahmin? '
    guess = gets.chomp.to_i

    if number == guess
      puts 'Başardınız!'
      break
    else
      puts 'Hatalı tahmin; lütfen tekrar deneyin!'
    end
  end

  puts 'Bizi denediğiniz için teşekkürler!'
end

def main0
  number = rand(5) + 1

  print 'Tahmin? '
  guess = gets.chomp.to_i

  if number == guess
    puts 'Başardınız!'
  else
    puts 'Hatalı tahmin!'
  end
end

main

exit

def getnum
  print 'Lütfen bir sayı girin [ENTER sonlandırır]: '

  while !(string = gets.chomp).empty?
    number = Integer(string, exception: false)
    if number
      return number
    end

    print "Geçersiz sayı: '#{string}'.  Lütfen tekrar girin: "
  end

  nil
end

puts getnum
