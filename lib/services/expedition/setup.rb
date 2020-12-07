# frozen_string_literal: true

##
# Services is a module under which are implemented all needed operations
module Services
  module Expedition
    ##
    # Setup handles parsing of input and setting up an expedition
    # based on the given input
    class Setup
      attr_reader :expedition, :raw_input

      ##
      # @param input [Text] raw text of input
      def initialize(input)
        @raw_input = input
        @expedition = Models::Expedition.new
      end

      ##
      # Sets up expedition
      #
      # @return [Models::Expedition] with all extracted data from input
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
          rover = Models::Rover.new([x.to_i, y.to_i], expedition.ending_coordinates, orientation)
          populate_rover(rover)
          populate_instructions(instructions)
        end
        expedition
      end

      ##
      # Populates a single rover
      #
      # @param rover [Models::Rover]
      def populate_rover(rover)
        @expedition.rovers.push(rover)
      end

      ##
      # Populates a single set of instructions
      #
      # @param instructions [Array] array of parsed instructions
      def populate_instructions(instructions)
        @expedition.rovers_instructions.push(instructions)
      end

      class << self
        def call(input)
          new(input).call
        end
      end
    end
  end
end
