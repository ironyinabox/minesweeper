require_relative 'tile.rb'

class Board
  BOARD_DIM = 9
  BOMBS_NUM = 10

  attr_accessor :board

  def initialize
    board = Array.new(BOARD_DIM ** 2) { Tile.new(false) }

    BOMBS_NUM.times { |i| board[i].is_bomb = true }
    board.shuffle!
    @board = board.each_slice(BOARD_DIM).to_a

    @board.each_with_index do |row, idx|
      row.each_with_index do |tile, idy|
        count = 0
        Tile.neighbors([idx, idy], self).each do |neighbor|
          count += 1 if neighbor.is_bomb?
        end
        tile.neighbor_bomb_count = count
      end
    end

  end

  def [](x, y)
    board[x][y]
  end

  def render
    board.each do |row|
      row.each do |tile|
        print tile.to_s
      end
      puts "\n"
    end
    puts "\n\n"
  end

  def in_bounds?(pos)
    pos.all? { |idx| idx.between?(0, BOARD_DIM-1) }
  end

  def revealed_tiles_count
    board.flatten.count { |tile| tile.status == :revealed }
  end

  def bomb_revealed?
    board.flatten.any? { |tile| tile.is_bomb? && tile.status == :revealed }
  end

end
