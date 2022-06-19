#Board
# _1_|_2_|_3_
# _4_|_5_|_6_
#  X | 8 | 9

#Initial UI
  #Welcome message
  #Random selection for who goes first

#Display board with numbered rows and columns

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
    puts "_#{item[0]}_|_#{item[1]}_|_#{item[2]}_"
    puts "_#{item[3]}_|_#{item[4]}_|_#{item[5]}_"
    puts " #{item[6]} | #{item[7]} | #{item[8]} "
  end
end

class NewGame
  include GamePrompts
  include Board

  @@PLAYERS = ["Player 1", "Player 2"]

  attr_reader :current_player

  def initialize()
    @current_player = ((rand(2) == 0)? @@PLAYERS[0]: @@PLAYERS[1])
    @board_slots = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  end

  def prompt_current_player
    puts "It is #{self.current_player}'s turn. Please pick a spot to play:"
    gets.chomp.to_i
  end

  private
    def swap_player
      (@current_player == @@PLAYERS[0])? @current_player = @@PLAYERS[1]: @current_player = @@PLAYERS[0]
    end
end

puts "Welcome! Grab a friend and get ready for some Tic Tac Toe!"
new_game = NewGame.new()
new_game.prompt_current_player