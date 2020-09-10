require "pry"
class Board
  attr_accessor :cells

  def initialize
    reset!
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(input)
    user_input = input.to_i - 1
    @cells[user_input]
  end

  def full?
    if @cells.all?{|value| value != " "}
      true
    else
      false
    end
  end

  def turn_count
    @cells.count("X") + @cells.count("O")
  end

  def taken?(input)
    if position(input) == "X"
      true
    elsif position(input) == "O"
      true
    elsif position(input) == " "
      false
    end
  end

  def valid_move?(input)
    if input.to_i.between?(1, 9)
      if taken?(input) == true
        false
      elsif taken?(input) == false
        true
      end
    else
      false
    end
  end

  def update(index, player)
    @cells[index.to_i - 1] = player.token
  end

end
