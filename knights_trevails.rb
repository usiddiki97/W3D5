require_relative "./skeleton/lib/00_tree_node.rb"
require "byebug"
#Knight's Travails

# Read through all the instructions before beginning!

# Learning Goals

# Be able to implement your PolyTreeNode to build a path from start to finish
# Know how to store and traverse a tree
# Know when and why to use BFS vs. DFS
# Phase 0: Description

# In this project we will create a class that will find the shortest path for
# a Chess Knight from a starting position to an end position. Both the start
# and end positions should be on a standard 8x8 chess board.

# NB: this problem is a lot like word chains!

# Write a class, KnightPathFinder. Initialize your KnightPathFinder with a
# starting position. For instance:

# kpf = KnightPathFinder.new([0, 0])
# Ultimately, I want to be able to find paths to end positions:

# kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
# kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]
# To help us find paths, we will build a move tree. The values in the tree will
# be positions. A node is a child of another node if you can move from the
# parent position directly to the child position. The root node of the tree
# should be the knight's starting position. You will want to build on your
# PolyTreeNode work, using PolyTreeNode instances to represent each position.
class KnightPathFinder
# Start by creating an instance variable, self.root_node that stores the
# knight's initial position in an instance of your PolyTreeNode class.


# Phase I: #new_move_positions

# Before we start #build_move_tree, you'll want to be able to find new positions
# you can move to from a given position. Write a class method KnightPathFinder::valid_moves(pos).
# There are up to eight possible moves.
    attr_reader :start_pos, :root_node
    attr_accessor :considered_positions
    MOVES = [[-2,-1],[-2,1],[2,-1],[2,1],[-1,-2],[-1,2],[1,-2],[1,2]]
    def self.valid_moves(pos) 
        row, col = pos 
        new_positions = MOVES.map do |move|
            [row + move.first, col + move.last]
        end

        new_positions.select do |move|
            move.first.between?(0,7) && move.last.between?(0,7)
        end
    end

    def initialize(start_pos)
        @start_pos = start_pos
        @considered_positions = [start_pos]
        @root_node = PolyTreeNode.new(start_pos)
        build_move_tree
    end

    
    # Phase II: #build_move_tree
    # You will be writing an instance method KnightPathFinder#build_move_tree to
    # build the move tree, beginning with self.root_node. Call this method in
    # initialize; You will traverse the move tree whenever #find_path is called.
    # Don't write this yet though.
    # Let's return to #build_move_tree. We'll use our #new_move_positions instance method.
    
    # To ensure that your tree represents only the shortest path to a given position,
    # build your tree in a breadth-first manner. Take inspiration from your BFS
    # algorithm: use a queue to process nodes in FIFO order. Start with a root node
    # representing the start_pos and explore moves from one position at a time.

    # Next build nodes representing positions one move away, add these to the queue.
    # Then take the next node from the queue... until the queue is empty.

    # When you have completed, and tested, #build_move_tree get a code review from your TA.

    def new_move_positions(pos)
        variable = KnightPathFinder.valid_moves(pos)
        # debugger if variable == nil
        variable.reject{|new_pos| considered_positions.include?(new_pos)} 
            .each {|new_pos| considered_positions << new_pos}
    end
    
    def build_move_tree
        queue = [root_node]
        until queue.empty?

            cur_node = queue.shift
            cur_pos = cur_node.value
 
            new_move_positions(cur_pos).each do |new_pos|
    
                new_node = PolyTreeNode.new(new_pos)
                cur_node.add_child(new_node)
                queue << new_node 
    
            end
        end
    end
end

if $PROGRAM_NAME ==__FILE__
    kpf = KnightPathFinder.new([0,0])
end


# Head to Part 2!

# Once you are finished with phases 1 & 2 head over to Part Two.