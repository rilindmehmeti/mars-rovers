# frozen_string_literal: true

module Models
  ##
  # Rover holds information for current position, current direction
  # has ability to move and rotate.
  class Rover
    attr_accessor :x_coordinate, :y_coordinate, :orientation

    ##
    # @param coordinates [Array] coordinates of the initial position. It should
    # be represented with two elements the first one representing x coordinate,
    # the second one representing y coordinate
    # @param orientation  [String] orientation in which Rover is headed.
    # It should have 4 possible values 'E' for east, 'N' for north,
    # 'S' for south and 'W' for west.
    def initialize(coordinates, orientation)
      @x_coordinate = coordinates[0]
      @y_coordinate = coordinates[1]
      @orientation  = orientation
    end

    ##
    # Changes coordinates of the rover
    def move
      new_coordinates = Services::Rover::Move.call(self)
      @x_coordinate   = new_coordinates[0]
      @y_coordinate   = new_coordinates[1]
    end

    ##
    # Changes the direction of the rover
    #
    # @param direction [String] direction in which the rover has to rotate
    def rotate(direction)
      @orientation = Services::Rover::Rotate.call(self, direction)
    end
  end
end
