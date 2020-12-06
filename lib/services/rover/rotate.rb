# frozen_string_literal: true

##
# Services is a module under which are implemented all needed operations
module Services
  module Rover
    ##
    # Rover::Rotate encapsulates the logic of rover rotation
    class Rotate
      ##
      # Configuration of possible rotation combinations,
      # based on current orientation and rotation direction
      CONFIGURATION = {
          NR: "E", NL: "W", ER: "S", WR: "N",
          EL: "N", SR: "W", SL: "E", WL: "S"
      }.freeze

      attr_reader :orientation, :direction

      ##
      # @param rover     [Models::Rover] rover which needs to be rotated
      # @param direction [String]        direction in which rover
      # will be rotated can be either 'R' or 'L'
      def initialize(rover, direction)
        @orientation = rover.orientation
        @direction   = direction
      end

      ##
      # Executes rover rotation
      #
      # @return [String] the orientation of rover after rotation
      # can be one of ['E', 'S', 'N', 'W']
      def call
        next_orientation = CONFIGURATION[configuration_key]
        raise NotImplementedError if next_orientation.nil?

        next_orientation
      end

      ##
      # Gives back configuration key accessing CONFIGURATION
      #
      # @return [String] returns key for accessing CONFIGURATION
      def configuration_key
        "#{orientation}#{direction}".to_sym
      end

      class << self
        def call(rover, direction)
          new(rover, direction).call
        end
      end
    end
  end
end
