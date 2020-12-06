# frozen_string_literal: true

##
# Services is a module under which are implemented all needed operations
module Services
  module Rover
    ##
    # Rover::ExecuteInstructions encapsulates the logic of executing instructions for rover
    class ExecuteInstructions
      attr_reader :rover, :instructions

      ##
      # @param rover        [Models::Rover] rover which needs to execute instructions
      # @param instructions [Array]         instructions that need to be executed
      def initialize(rover, instructions)
        @rover        = rover
        @instructions = instructions
      end

      ##
      # Executes instructions for the given rover
      def call
        instructions.each do |instruction|
          rover.execute_instruction(instruction)
        end
      end

      class << self
        def call(rover, direction)
          new(rover, direction).call
        end
      end
    end
  end
end
