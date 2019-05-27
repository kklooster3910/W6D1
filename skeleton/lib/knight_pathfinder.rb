require_relative '00_tree_node'
require 'byebug'
class KnightPathFinder

    attr_reader :considered_pos, :root_node

    MOVES = [ 
        [-2, 1],
        [-2, -1],
        [-1, 2],
        [-1, -2],
        [1, 2],
        [1, -2],
        [2, 1],
        [2, -1]]

    def initialize(pos)  #[0,0]
       @root_node = PolyTreeNode.new(pos)
       @considered_pos = [pos]
    end
    
    def self.valid_moves(pos) # board 8 x 8  x, y can't be above 8 or below 0
        valid = []
        MOVES.each do |move|
            #pos[0] + move[0] 0 - 7
            #pos[1] + move[1] 0 - 7
            new_move = [pos[0] + move[0], pos[1] + move[1]]
            valid << new_move if KnightPathFinder.on_board?(new_move)
        end
        valid
    end

    def self.on_board?(pos) #[0,0]
        pos[0] >= 0 && pos[0] <= 7 && pos[1] >= 0 && pos[1] <= 7 
    end

    def new_move_positions(pos)
        v_moves = KnightPathFinder.valid_moves(pos) 
        # @considered_pos.each do |pos|
        #    v_moves.delete(pos) if @considered_pos.include?(pos)
        # end
        v_moves.reject! { |move| @considered_pos.include?(move) }
        # debugger
        @considered_pos += v_moves 
        v_moves
    end

    def build_move_tree(root_node)
        queue = [root_node]
        ret = []
        # debugger
        until queue.empty?
            current = queue.shift
            new_move_positions(current.value).each do |move|
                ret << current
                new_node = PolyTreeNode.new(move)
                # current.parent = new_node
                new_node.parent = current
                # current.add_child(new_node)
                queue << new_node
            end
        end
        ret
    end
end