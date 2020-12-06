# frozen_string_literal: true

##
# Services is a module under which are implemented all needed operations
module Services
  module Expedition
    ##
    # Navigate is used to execute the instructions for rovers included on the
    # expedition
    class Navigate
      attr_reader :expedition

      ##
      # @param expedition [Models::Expedition] expedition which needs to be
      # navigated
      def initialize(expedition)
        @expedition = expedition
      end

      ##
      # Executes instructions for each rover
      def call
        expedition.rovers.each_with_index do |rover, index|
          Services::Rover::ExecuteInstructions.call(rover, expedition.rovers_instructions[index])
        end
      end

      class << self
        def call(expedition)
          new(expedition).call
        end
      end
    end
  end
end
