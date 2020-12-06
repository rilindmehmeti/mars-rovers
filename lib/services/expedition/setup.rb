# frozen_string_literal: true

##
# Services is a module under which are implemented all needed operations
module Services
  module Expedition
    ##
    # ParseInput handles parsing of input. Holds information of rovers initial
    # positions and their instructions, as well information of
    # ending_coordinates of plateau
    class Setup
      attr_reader :expedition, :raw_input

      ##
      # @param input [Text] raw text of input
      def initialize(input)
        @raw_input = input
        @expedition = Models::Expedition.new
      end

      ##
      # Parses the given input
      #
      # @return [Hash] that contains an array of rovers initialized with
      # current position, an array of rover instructions and
      # ending coordinates
      def call
        parsed_input = raw_input.split("\n")
        @expedition.ending_coordinates = parsed_input
                                         .shift.strip
                                         .split(" ").map(&:to_i)
        populate_rovers(parsed_input)
      end

      private

      ##
      # Populates rovers and rovers instructions
      #
      # @param parsed_input [Array] contains the list of rovers
      # and rovers instructions
      #
      # @return [Models::Expedition] an expedition with information
      def populate_rovers(parsed_input)
        until parsed_input.empty?
          x, y, orientation = parsed_input.shift.split(" ")
          instructions      = parsed_input.shift.split("")
          rover = Models::Rover.new([x.to_i, y.to_i], orientation)
          @expedition.rovers.push(rover)
          @expedition.rovers_instructions.push(instructions)
        end
        expedition
      end

      class << self
        def call(input)
          new(input).call
        end
      end
    end
  end
end
