#!/usr/bin/env ruby

require 'digest'

if ARGV.length != 2
  puts "Usage: 10-password_cracked.rb HASHED_PASSWORD DICTIONARY_FILE"
  exit
end

hashed_password = ARGV[0]
dictionary_file = ARGV[1]

File.foreach(dictionary_file) do |word|
  password = word.chomp
  hash = Digest::SHA256.hexdigest(password)

  if hash == hashed_password
    puts "Password found: #{password}"
    exit
  end
end

puts "Password not found in dictionary."
