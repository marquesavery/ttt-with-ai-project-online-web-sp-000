require 'pry'
class Game
  # include Players::Human

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
     [0,1,2],
     [3,4,5],
     [6,7,8],
     [0,3,6],
     [1,4,7],
     [2,5,8],
     [0,4,8],
     [2,4,6]
     ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def current_player
    if @board.turn_count.even?
      @player_1
    elsif @board.turn_count.odd?
      @player_2
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board.cells[win_index_1]
      position_2 = @board.cells[win_index_2]
      position_3 = @board.cells[win_index_3]
      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      end
    end
    false
  end

  def draw?
    if @board.full?
      if won? == false
        true
      end
    end
  end

  def over?
    won? || draw?
  end

  def winner
    if won?
      index = won?[0]
      @board.cells[index]
    end
  end

  def turn
    puts "#{current_player.name} it is your move."
    index = current_player.move(@board)
    while @board.valid_move?(index) == false
      puts "#{current_player.name} please make a valid move."
      @board.display
      index = current_player.move(@board)
    end
    @board.update(index, current_player)
  end

  def play
    @board.display
    until over?
      turn
      @board.display
    end
    if won?
      puts "Congratulations #{winner}!"
      @board.display
    end
    if draw?
      puts "Cat's Game!"
      @board.display
    end
  end

  def self.start
    puts "What kind of game do you want to play, 0, 1, 2 player?"
    game_type = gets.chomp
    # binding.pry
    if game_type == "2"
      puts "Enter the name of player one (X)."
      first_user = gets.chomp
      puts "Enter the name of player two (O)."
      second_user = gets.chomp
      current_game = Game.new
    elsif game_type == "1"
      puts "Enter the name of the player (X)."
      first_user = gets.chomp
      second_user = "computer two"
      current_game = Game.new(Players::Human.new("X"), Players::Computer.new("O"))
    elsif game_type == "0"
      first_user = "computer one"
      second_user = "computer two"
      current_game = Game.new(Players::Computer.new("X"), Players::Computer.new("O"))
    end

    current_game.player_1.name = first_user
    current_game.player_2.name = second_user

    current_game.play
  end

end
