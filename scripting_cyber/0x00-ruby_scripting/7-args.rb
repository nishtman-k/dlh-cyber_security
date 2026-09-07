#!/usr/bin/env ruby

def print_arguments
  # 1. Check if the ARGV array is empty
  if ARGV.empty?
    puts "No arguments provided."
  else
    # 2. If not empty, loop through arguments with their index numbers
    ARGV.each_with_index do |arg, index|
      # index starts at 0, so we add 1 to display 1, 2, 3...
      puts "#{index + 1}. #{arg}"
    end
  end
end
