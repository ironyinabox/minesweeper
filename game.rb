require_relative 'board.rb'
require_relative 'tile.rb'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    system('clear')
    until over?
      board.render
      begin
        action, coordinate = prompt
      end until valid?(coordinate)
      if action == "R"
        board.reveal_tile(coordinate)
      else
        board.flag_tile(coordinate)
      end
      system('clear')
    end
    board.render
    if won?
      puts "CONGRATS YOU WIN"
    else
      puts "x.x"
    end
  end

  def prompt
    puts "F/R which coordinate? (ie F 0,0)"
    action, coordinate = gets.chomp.split
    coordinate = coordinate.split(",").map(&:to_i)
    [action, coordinate]
  end

  def valid?(pos)
    board.in_bounds?(pos) && board[*pos].status == :hidden
  end

  def won?
    board.revealed_tiles_count == (Board::BOARD_DIM ** 2) - Board::BOMBS_NUM
  end

  def dead?
    board.bomb_revealed?
  end

  def over?
    won? || dead?
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
