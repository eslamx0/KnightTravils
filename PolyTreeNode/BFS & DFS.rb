module Searching_algo

    def bfs(target)
        return nil if self.nil?
        queue = [self]

        until queue.empty?
            node = queue.shift
            return node if node.value == target

            node.children.each do |child|
                queue << child
            end
        end
            
    end

    def dfs(target)        
        return nil if self.nil?
        return self if self.value == target

        self.children.each do |child|
            result = child.dfs(target)
            return result unless  result.nil?
        end

        nil
    end

end


