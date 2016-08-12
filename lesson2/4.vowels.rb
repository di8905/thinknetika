ALPHABET = ("a".."z")
VOWELS   = ["a", "e", "i", "o", "u", "y"]
wov_hash = {}
ALPHABET.each_with_index do |letter, i|
  wov_hash[letter.to_sym] = i if VOWELS.include?(letter)
end #Несколько избыточно, но для тренировки с константами захотелось
p wov_hash
