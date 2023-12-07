require_relative "BFS & DFS.rb"

class PolyTreeNode
    include Searching_algo

    attr_reader :value, :parent
    def initialize(value)
        @value, @parent, @children = value, nil, []
    end

    def children
        @children.dup
    end

    def count 
        self.children.count
    end
    def inspect
        # { 'value' => @value, 'parent_value' => @parent.value }.inspect
        { 'value' => @value }.inspect
    end

    def value=(value)
        @value = value
    end
    def parent=(parent)
        return if self.parent == parent
        #unless parent is nill because if parent is nill it won't be able to call _children method because nil isn't an instance of the class
        self.parent._children.delete(self) unless self.parent.nil?
        @parent = parent
        parent._children << self unless parent.nil?
    end

    #adds a child to self node
    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        #raising error if the child isn't a self's child
        unless self._children.include?(child)
            raise "wrong entry not this node child" 
            return
        end

        self._children.delete(child)
        child.parent = nil

    end

    protected 
    def _children
        @children
    end

end

