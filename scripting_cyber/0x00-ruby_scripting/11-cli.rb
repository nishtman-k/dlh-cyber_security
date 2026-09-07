#!/usr/bin/env ruby

require 'optparse'

TASKS_FILE = 'tasks.txt'

options = {}

parser = OptionParser.new do |opts|
  opts.banner = 'Usage: cli.rb [options]'

  opts.on('-a TASK', '--add TASK', 'Add a new task') do |task|
    options[:add] = task
  end

  opts.on('-l', '--list', 'List all tasks') do
    options[:list] = true
  end

  opts.on('-r INDEX', '--remove INDEX', Integer, 'Remove a task by index') do |index|
    options[:remove] = index
  end

  opts.on('-h', '--help', 'Show help') do
    puts opts
    exit
  end
end

begin
  parser.parse!
rescue OptionParser::ParseError => e
  puts e.message
  puts parser
  exit 1
end

if options[:add]
  File.open(TASKS_FILE, 'a') do |file|
    file.puts options[:add]
  end

  puts "Task '#{options[:add]}' added."

elsif options[:list]
  puts 'Tasks:'

  if File.exist?(TASKS_FILE)
    tasks = File.readlines(TASKS_FILE, chomp: true)

    tasks.each_with_index do |task, index|
      puts "#{index + 1}. #{task}"
    end
  end

elsif options[:remove]
  index = options[:remove]

  if File.exist?(TASKS_FILE)
    tasks = File.readlines(TASKS_FILE, chomp: true)

    if index >= 1 && index <= tasks.length
      removed_task = tasks.delete_at(index - 1)

      File.write(TASKS_FILE, tasks.join("\n"))
      File.open(TASKS_FILE, 'a') { |file| file.write("\n") } unless tasks.empty?

      puts "Task '#{removed_task}' removed."
    end
  end
end
