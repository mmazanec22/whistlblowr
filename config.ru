# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

$stdout.sync = true

puts "logging... hello world..."
puts "oh and, this is what happened"
$stdout.flush