require_relative 'board.rb'
require_relative 'tile.rb'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    until over?
      board.render
      action, coordinate = prompt
      if action == "R"
        board.reveal(coordinate)
      else
        board.flag(coordinate)
      end
      board.render
    end

    puts "CONGRATS YOU WIN"
  end

  def prompt
    puts "F/R which coordinate? (ie F 0,0)"
    action, coordinate = gets.chomp.split
    coordinate = coordinate.split(",").map(&:to_i)
    [action, coordinate]
  end

  def won?
    board.revealed_tiles_count == (Board::BOARD_DIM ** 2) - Board::BOMBS_NUM
  end

  def dead?

  end

  def over?
    won? || dead?
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.render
  b[0,0].reveal
  b.render
  p Tile.neighbors([0, 0], b)
end
