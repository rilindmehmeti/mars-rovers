# frozen_string_literal: true

Dir[File.expand_path("lib/**/*.rb", Dir.pwd)].each do |f|
  require f
end

def print_line_separator
  puts "================================="
end

##
# Test Input from the case
input = <<~HEREDOC
  5 5
  1 2 N
  LMLMLMLMM
  3 3 E
  MMRMMRMRRM
HEREDOC

##
# Test input that breaks instructions
# input = <<~HEREDOC
#   5 5
#   1 2 N
#   LMLMLMLMMD
#   3 3 E
#   MMRMMRMRRM
# HEREDOC

##
# Test input that makes rover go out of space
# input = <<~HEREDOC
#   5 5
#   5 5 N
#   MMLRM
# HEREDOC

puts ""
puts "Running Mars Rover Expedition....."
print_line_separator
puts "Input:"
print_line_separator
puts input
print_line_separator

begin
  expedition = Services::Expedition::Setup.call(input)
  Services::Expedition::Navigate.call(expedition)

  puts "Output:"
  print_line_separator
  puts expedition.print
  print_line_separator
  puts ""
  puts "Please visit Mars again!"
rescue Errors::ControlledError => e
  puts "Something went wrong during our Expedition :("
  puts ""
  puts "Expedition failed with message:"
  puts e.message
  print_line_separator
end
