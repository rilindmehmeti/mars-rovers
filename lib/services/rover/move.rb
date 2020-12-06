# frozen_string_literal: true

##
# Services is a module under which are implemented all needed operations
module Services
  module Rover
    ##
    # Rover::Move encapsulates the logic of rover movement
    class Move
      attr_reader :x, :y, :orientation

      ##
      # @param rover [Models::Rover] rover which needs to move
      def initialize(rover)
        @x = rover.x_coordinate
        @y = rover.y_coordinate
        @orientation = rover.orientation
      end

      ##
      # Executes rover movement
      #
      # @return x,y [Int, Int] x,y are coordinates of rover after movement
      def call
        case orientation
        when "N"
          @y = y + 1
        when "E"
          @x = x + 1
        when "S"
          @y = y - 1
        when "W"
          @x = x - 1
        else
          raise NotImplementedError
        end
        [x, y]
      end

      class << self
        def call(rover)
          new(rover).call
        end
      end
    end
  end
end
