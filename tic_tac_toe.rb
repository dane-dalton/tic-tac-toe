#Board
# _1_|_2_|_3_
# _4_|_5_|_6_
#  X | 8 | 9

# XXX Initial UI
  # XXX Welcome message
  # XXX Random selection for who goes first

#Display board with numbered slots

  #Check if there is an open space
    #Play unless there are no spaces open
      #Prompt a draw, ask if they would like to play a new game

  #Ask which row they would like to pick, then column

  #See if the spot is filled
    #Prompt for another selection if the spot is filled

  #Fill the spot

  #Check if the game is over
    #If done, prompt the winner
      #Ask to play again
    #else, switch turns

module GamePrompts
  def player_choice(player)
    puts "It is #{player}'s turn. Please pick a spot to play."
    gets.chomp.to_i 
  end
end

module Board
  def current_board(items)
    puts "_#{items[0]}_|_#{items[1]}_|_#{items[2]}_"
    puts "_#{items[3]}_|_#{items[4]}_|_#{items[5]}_"
    puts " #{items[6]} | #{items[7]} | #{items[8]} "
  end
end

class NewGame
  include GamePrompts
  include Board

  @@PLAYERS = ["Player 1", "Player 2"]

  attr_reader :current_player
  attr_accessor :game_continues

  def initialize()
    @current_player = ((rand(2) == 0)? @@PLAYERS[0]: @@PLAYERS[1])
    @board_slots = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @game_continues = true
  end

  def get_player_position
    puts "It is #{self.current_player}'s turn. Please pick a spot to play:"
    input = gets.chomp.to_i
    while (input <= 0 || input > 9) do #Input validation
      puts "Please pick a valid tile to play:"
      input = gets.chomp.to_i
    end
    insert_tile(self.current_player, input)
  end

  def swap_player
    (@current_player == @@PLAYERS[0])? @current_player = @@PLAYERS[1]: @current_player = @@PLAYERS[0]
  end

  def display_board
    current_board(@board_slots)
  end

  private
    def insert_tile(player, i)
      @board_slots[i - 1] = "X" if player == @@PLAYERS[0]
      @board_slots[i - 1] = "O" if player == @@PLAYERS[1]
    end
end

puts "Welcome! Grab a friend and get ready for some Tic Tac Toe!"
game = NewGame.new()

while (game.game_continues) do
  game.display_board
  game.get_player_position
  game.display_board

  game.game_continues = false
end
