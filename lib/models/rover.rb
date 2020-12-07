# frozen_string_literal: true

module Models
  ##
  # Rover holds information for current position, current direction, ending coordinates of plateau,
  # has ability to move and rotate.
  class Rover
    MOVE_INSTRUCTION    = "M"
    ROTATE_INSTRUCTIONS = %w[R L].freeze

    attr_accessor :x_coordinate, :y_coordinate, :orientation, :ending_coordinates

    ##
    # @param coordinates [Array] coordinates of the initial position. It should
    # be represented with two elements the first one representing x coordinate,
    # the second one representing y coordinate
    # @param ending_coordinates [Array] coordinates of the ending position of plateau. It should
    # be represented with two elements the first one representing x coordinate,
    # the second one representing y coordinate
    # @param orientation  [String] orientation in which Rover is headed.
    # It should have 4 possible values 'E' for east, 'N' for north,
    # 'S' for south and 'W' for west.
    def initialize(coordinates, ending_coordinates, orientation)
      @x_coordinate       = coordinates[0]
      @y_coordinate       = coordinates[1]
      @ending_coordinates = ending_coordinates
      @orientation        = orientation
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

    ##
    # Executes instruction
    #
    # @param instruction [String] instruction which needs to be executed should be in ['R','L', 'M']
    def execute_instruction(instruction)
      return move if instruction == MOVE_INSTRUCTION
      return rotate(instruction) if ROTATE_INSTRUCTIONS.include?(instruction)

      raise Errors::NotAllowedInstruction, "Instruction '#{instruction}' is not allowed!"
    end

    ##
    # Prints current state of the rover
    #
    # @return "x y o" [String] where x is x_coordinate, y is y_coordinate and o is orientation
    def print
      "#{x_coordinate} #{y_coordinate} #{orientation}"
    end
  end
end
