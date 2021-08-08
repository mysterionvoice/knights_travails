class KnightMove
    attr_accessor :parent, :position, :destination
    MOVES = [[2, 1], [2, -1], [-2, 1], [2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]].freeze
  
    def initialize(position, destination, parent = nil)
      @parent = parent
      @position = position
      @destination = destination
      @path = []
      @path << [position]
    end
  
    def moves
      MOVES.map { |move| [@position[0] + move[0], @position[1] + move[1]] }
           .keep_if { |move| legal?(move) }
           .map { |move| KnightMove.new(move, @destination, self) }
    end
  
    def legal?(move)
      move[0].between?(1, 8) && move[1].between?(1, 8) && !@path.include?(move)
    end
  end
  
  def pretty_print(node, start = nil, destination = nil, first_call = false)
    puts "To move from #{start} to #{destination}, you need to make the following moves:" if first_call
    pretty_print(node.parent) unless node.parent.nil?
    node.position[0] = 96 + node.position[0]
    puts "N#{node.position[0].chr}#{node.position[1]}"
  end
  
  def debug_print(node)
    debug_print(node.parent) unless node.parent.nil?
    puts node
  end
  
  def knight_moves(start, stop)
    return unless move_allowed(start, stop)
  
    queue = []
    move_node = KnightMove.new(start, nil)
    until move_node.position == stop
      move_node.moves.each { |move| queue.push(move) }
      move_node = queue.shift
    end
    pretty_print(move_node, start, stop, true)
  end
  
  def move_allowed(start, stop)
    if !start[0].between?(1, 8) || !start[1].between?(1, 8) || !stop[0].between?(1, 8) || !stop[1].between?(1, 8)
      puts 'Please enter numbers between 1 and 8!'
      return false
    elsif start == stop
      puts "You can't move a knight to a square it occupies!"
      return false
    end
    true
  end