require 'byebug'

class Tile
  attr_accessor :is_bomb, :status, :neighbors

  #status can be hidden, revealed, flagged

  def initialize(is_bomb)
    @is_bomb = is_bomb
    @status = :hidden
    @neighbors = []
  end


  def reveal
  end

  def neighbors
  end

  def neighbor_bomb_count
  end

  def is_bomb?
    is_bomb
  end

  def to_s
    is_bomb? ? "*" : "_"
  end

end

class Board
  BOARD_DIM = 9
  BOMBS_NUM = 10

  attr_accessor :board

  def initialize
    board = Array.new(BOARD_DIM ** 2) {Tile.new(false)}
    # debugger
    BOMBS_NUM.times { |i| board[i].is_bomb = true }
    board.shuffle!
    @board = board.each_slice(BOARD_DIM).to_a
  end

  def render
    board.each do |row|
      row.each do |tile|
        print tile.to_s
      end
      puts "\n"
    end
  end

end

class Game
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.render
end
