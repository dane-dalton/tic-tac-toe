#Board
# _1_|_2_|_3_
# _4_|_5_|_6_
#  X | 8 | 9

# XXX Initial UI
  # XXX Welcome message
  # XXX Random selection for who goes first

# XXX Display board with numbered slots

  # XXX Check if there is an open space
    # XXX Play unless there are no spaces open
      # XXX Prompt a draw, ask if they would like to play a new game

  # XXX Ask which slot they would like to pick

  # XXX See if the spot is filled
    # XXX Prompt for another selection if the spot is filled

  # XXX Fill the spot

  #Check if the game is over
    #If done, prompt the winner
      #Ask to play again
    #else, switch turns

module Board
  def current_board(items)
    puts "_#{items[0]}_|_#{items[1]}_|_#{items[2]}_"
    puts "_#{items[3]}_|_#{items[4]}_|_#{items[5]}_"
    puts " #{items[6]} | #{items[7]} | #{items[8]} "
  end
end

class NewGame
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
    while (input <= 0 || input > 9 || slot_full?(input)) do #Input validation
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

  def board_full?
    @board_slots.all? { |slot| slot == "X" || slot == "O" }
  end

  def check_winner?
    @board_slots.each_with_index do |slot, i|
      #Check column win
      if (i >= 0 && i < 3)
        if (@board_slots[i + 3] == slot && @board_slots[i + 6] == slot)
          return true
        end
      end
      #Check row win
      if (i == 0 || i == 3 || i == 6)
        if(@board_slots[i + 1] == slot && @board_slots[i + 2] == slot)
          return true
        end
      end
      #Check diagonal wins
      if i == 0
        if (@board_slots[4] == slot && @board_slots[8] == slot)
          return true
        end
      end
      if i == 6
        if(@board_slots[4] == slot && @board_slots[2] == slot)
          return true
        end
      end
      return false
    end
  end

  private
    def insert_tile(player, i)
      @board_slots[i - 1] = "X" if player == @@PLAYERS[0]
      @board_slots[i - 1] = "O" if player == @@PLAYERS[1]
    end

    def slot_full?(i)
      @board_slots[i - 1] == "X" || @board_slots[i - 1] == "O"
    end
end

puts "Welcome! Grab a friend and get ready for some Tic Tac Toe!"
game = NewGame.new()

while (game.game_continues) do
  game.display_board
  game.get_player_position
  if game.check_winner?
    puts game.check_winner?
    puts "#{game.current_player} is the winner! Restart to play again."
    game.game_continues = false
    break
  end

  game.swap_player
  
  if game.board_full?
    puts "It's a draw! Restart to play again."
    game.game_continues = false
  end
end
