#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'json'

def get_request(url)
  # 1. Convert the string URL into a URI object
  uri = URI.parse(url)

  # 2. Perform the HTTP GET request
  response = Net::HTTP.get_response(uri)

  # 3. Print the status code and status message (e.g., "200 OK")
  puts "Response status: #{response.code} #{response.message}"

  # 4. Parse the body as JSON and pretty print it
  parsed_body = JSON.parse(response.body)
  puts "Response body:"
  puts JSON.pretty_generate(parsed_body)
end
