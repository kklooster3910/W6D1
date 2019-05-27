require 'byebug'
class PolyTreeNode

    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @children = []
        @parent = nil
    end

    def parent=(node)
        # @parent = nil
        # debugger
        # if @parent
        #     node.parent.children.delete(node)   
        #     @parent = node
        # end
        # node.children << self unless node.children.include?(self)
        @parent.children.delete(self) if @parent
        @parent = node
        node.children << self unless node.nil? || @parent.children.include?(node)
      
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "node is not a child" unless child_node.parent.children.include?(child_node)
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child|
            next_node = child.dfs(target_value)
            return next_node if next_node
        end
        nil
    end
    
    def bfs(target_value)
        queue = [self]
        until queue.length == 0
            current = queue.shift
            return current if current.value == target_value
            queue += current.children
        end
        nil
    end

end
