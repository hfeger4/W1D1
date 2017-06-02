class Player
  attr_accessor :name
  def initialize(name)
    @name = name
    @guess = ""
  end

  def guess
    print "Please enter a letter: "
    guess_letter = gets.chomp.downcase
    alert_invalid_guess(guess_letter)
  end

  def alert_invalid_guess(guess_letter)
    alphabet = ("a".."z").to_a
    unless alphabet.include?(guess_letter)
      puts "The guess is not valid! Please enter a single character."
      guess
    end
    guess_letter
  end
end
