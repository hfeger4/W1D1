require_relative 'player.rb'

class Ghost
  def initialize(players, fragment, dictionary)
    @dictionary = dictionary
    @player1 = players.first
    @player2 = players.last
    @current_player = @player1
    @fragment = fragment
  end

  def play_round
    puts "Round 1 of Ghost"
    display
    until won?(@fragment)
      take_turn(@current_player)
      display
      next_player!
    end
    puts "#{previous_player.name} has won the round!"
  end

  def current_player
    @current_player
  end

  def previous_player
    @player1 if @current_player == @player2
    @player2 if @current_player == @player1
  end

  def next_player!
    @current_player = @player2 if @current_player == @player1
    @current_player = @player1 if @current_player == @player2
  end

  def take_turn(player)
    guess_letter = player.guess
    temp_fragment = @fragment + guess_letter
    if valid_play?(temp_fragment)
      @fragment += guess_letter
    else
      puts "Not a valid play!"
      take_turn(player)
    end
  end

  def valid_play?(string)
    return true if @dictionary.any? { |word| word.start_with?(string) }
    false
  end

  def won?(string)
    return true if @dictionary.any? { |word| string == word }
    false
  end

  def display
    puts "\n"
    puts "#{@fragment} is the current fragment."
    puts "#{@current_player.name} is choosing!"
  end

end

if __FILE__ == $PROGRAM_NAME
  player1 = Player.new("Player1")
  player2 = Player.new("Player2")
  players = [player1, player2]
  dictionary = File.readlines('dictionary.txt')
  dictionary.map!(&:strip)
  fragment = "zo"
  new_game = Ghost.new(players, fragment, dictionary)
  new_game.play_round
end
