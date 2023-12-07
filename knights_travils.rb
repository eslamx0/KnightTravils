require_relative "./PolyTreeNode/PolyTreeNode.rb"
#KFS => Knight Path Finder
class KFS
    attr_reader :chess_board, :starting_position, :ending_position, :root_node, :ending_node

    def initialize(starting_position, ending_position)
        @chess_board = Array.new(8){ Array.new(8, "[ ]")}
        @starting_position = starting_position
        @ending_position = ending_position
        @root_node = PolyTreeNode.new(starting_position)
        @ending_node = PolyTreeNode.new(ending_position)
    end

    def print_chess_board
        print "  "
        (0..7).each {|col_idx| print " #{col_idx} "}
        puts

        row_idx = 0
        self.chess_board.each do |row|
            print "#{row_idx} "
            row_idx += 1
            row.each { |position| print position }
            puts
        end
        
        return
    end

    #o=> represents position changing operations for the knight 
    def o1(node)
        node.value = [node.value.first - 1, node.value.last - 2]
        node
    end
    def o2(node)
        node.value = [node.value.first + 1, node.value.last + 2]
        node
    end
    def o3(node)
        node.value = [node.value.first - 1, node.value.last + 2]
        node
    end
    def o4(node)
        node.value = [node.value.first + 1, node.value.last - 2]
        node
    end
    def o5(node)
        node.value = [node.value.first - 2, node.value.last - 1]
        node
    end
    def o6(node)
        node.value = [node.value.first + 2, node.value.last + 1]
        node
    end
    def o7(node)
        node.value = [node.value.first - 2, node.value.last + 1]
        node
    end
    def o8(node)
        node.value = [node.value.first + 2, node.value.last - 1]
        node
    end
    #

    #generation of children of any node using position changing operations
    def generate_family(root = self.root_node)
        ending_node = self.ending_node
        node_position = root.value

        
        
        root.add_child( o1( PolyTreeNode.new(node_position) ) )
        root.add_child( o2( PolyTreeNode.new(node_position) ) )
        root.add_child( o3( PolyTreeNode.new(node_position) ) )
        root.add_child( o4( PolyTreeNode.new(node_position) ) )
        root.add_child( o5( PolyTreeNode.new(node_position) ) )
        root.add_child( o6( PolyTreeNode.new(node_position) ) )
        root.add_child( o7( PolyTreeNode.new(node_position) ) )
        root.add_child( o8( PolyTreeNode.new(node_position) ) )
    end
    #

    #Searching through any node using BFS Algorithm
    def result_of_Searching_through_root(root)
        root.bfs(self.ending_position)
    end
    #

    #searching and generating at the same time ( horizontal ) using queue 
    def search_through(root)
        queue = [root]

        until result_of_Searching_through_root(root)
            node = queue.shift
            node.children.each do |child| 
                queue << child
                self.generate_family(child) 
            end
        end

        result_of_Searching_through_root(root)
    end
    #

    #Finding target obj which includes the ending position
    def find_target_obj
        #initialize the first root node by generating its children family
        self.generate_family(self.root_node)
        #This returns the object that includes the ending position
        self.search_through(self.root_node)

    end
    #

    #Finding path objects of the path from starting position to the ending position
    def find_path_objects
        target_obj = self.find_target_obj()
        path_objects = [target_obj]

        until target_obj.nil? 
            target_obj = target_obj.parent
            path_objects << target_obj
        end

        path_objects[0..-2].reverse
    end
    #

    #printing the path
    def print_path_positions
        path_objects = find_path_objects()

        path_objects.each_with_index do |p_obj, i|
            print "#{p_obj.value} "
            print "=>" if i < path_objects.length - 1
        end

        puts
        return true
    end
    #
    #Hisham Elmorsi
end
