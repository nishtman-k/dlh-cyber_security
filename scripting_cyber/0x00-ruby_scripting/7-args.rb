#!/usr/bin/env ruby

def print_arguments
  # 1. Check if the ARGV array is empty
  if ARGV.empty?
    puts "No arguments provided."
  else
    # 2. Print the main header required by the checker
    puts "Arguments:"

    # 3. Loop through and print each argument on a new line
    ARGV.each do |arg|
      puts arg
    end
  end
end
