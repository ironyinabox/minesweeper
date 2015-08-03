require_relative 'tile.rb'

class Board
  BOARD_DIM = 9
  BOMBS_NUM = 10

  attr_accessor :board

  def initialize_bomb_counts
    board.each_with_index do |row, idx|
      row.each_with_index do |tile, idy|
        count = 0
        Tile.neighbors([idx, idy], self).each do |neighbor|
          count += 1 if neighbor.is_bomb?
        end
        tile.neighbor_bomb_count = count
      end
    end
  end

  def initialize
    board = Array.new(BOARD_DIM ** 2) { Tile.new(false) }

    BOMBS_NUM.times { |i| board[i].is_bomb = true }
    board.shuffle!
    @board = board.each_slice(BOARD_DIM).to_a

    initialize_bomb_counts
  end

  def [](x, y)
    board[x][y]
  end

  def render
    puts "   0 1 2 3 4 5 6 7 8"
    puts "   -----------------"
    board.each_with_index do |row, idx|
      print "#{idx}: "
      row.each do |tile|
        print tile.to_s + " "
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

  def reveal_tile(pos)
    row, col = pos
    tile = self[row, col]
    if tile.status != :revealed && tile.status != :flagged
      tile.reveal
      if tile.neighbor_bomb_count == 0
        Tile.neighbors_coords(pos, self).each { |coord| reveal_tile(coord) }
      end
    end
  end

  def flag_tile(pos)
    row, col = pos
    tile = self[row, col]
    if tile.status != :revealed
      tile.flagged? ? tile.unflag : tile.flag
    else
      puts "Cannot flag the revealed!!!"
    end
  end
end
