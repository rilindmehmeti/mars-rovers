# frozen_string_literal: true

module Models
  ##
  # Expedition holds information for rovers, rovers instructions
  # and plateau coordinates
  class Expedition
    attr_accessor :rovers, :rovers_instructions, :ending_coordinates,
                  :starting_coordinates

    ##
    # Sets default values for rovers, rovers instructions
    # and plateau coordinates
    def initialize
      @rovers = []
      @rovers_instructions  = []
      @starting_coordinates = [0, 0]
      @ending_coordinates   = [0, 0]
    end
  end
end
