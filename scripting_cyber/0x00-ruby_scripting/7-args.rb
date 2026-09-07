#!/usr/bin/env ruby
def print_arguments
  if ARGV.empty?
    puts "No arguments provided."
  else
    puts "Arguments:"
    ARGV.each_with_index do |arg, i|
      puts "#{i + 1}. #{arg}"
    end
  end
end
