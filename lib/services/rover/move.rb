# frozen_string_literal: true

##
# Services is a module under which are implemented all needed operations
module Services
  module Rover
    ##
    # Rover::Move encapsulates the logic of rover movement
    class Move
      attr_reader :x, :y, :ending_x, :ending_y, :orientation

      ##
      # @param rover [Models::Rover] rover which needs to move
      def initialize(rover)
        @x           = rover.x_coordinate
        @y           = rover.y_coordinate
        @ending_x    = rover.ending_coordinates[0]
        @ending_y    = rover.ending_coordinates[1]
        @orientation = rover.orientation
      end

      ##
      # Executes rover movement
      #
      # @return x,y [Int, Int] x,y are coordinates of rover after movement
      def call
        calculate_movement
        raise Errors::PositionOutOfSpace if out_of_space?

        [x, y]
      end

      private

      ##
      # Calculates next position based on direction
      def calculate_movement
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
      end

      ##
      # Checks if rover is goes outside of bounding coordinates
      def out_of_space?
        return true if x > ending_x
        return true if y > ending_y
        return true if x.negative?
        return true if y.negative?

        false
      end

      class << self
        def call(rover)
          new(rover).call
        end
      end
    end
  end
end
