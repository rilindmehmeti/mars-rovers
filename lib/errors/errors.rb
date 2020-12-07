# frozen_string_literal: true

##
# Errors module implements new error classes declaration which are used to control failure flow
module Errors
  ##
  # ControlledError is used as superclass to handle controlled cases of exceptions.
  class ControlledError < ::RuntimeError; end
  ##
  # NotAllowedInstruction is used to identify instructions that break the setup of expedition
  class NotAllowedInstruction < ControlledError; end
  ##
  # PositionOutOfSpace is used to identify instructions that move the rover outside plateau space
  class PositionOutOfSpace < ControlledError; end
end
