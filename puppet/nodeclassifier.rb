#!/usr/bin/ruby
if m = /^([^-]+)-(.*?)-*(?<!\d)(\d*)(\.|$)/.match(ARGV[0])
  idx = m[3] != "" ? m[3] : "0"
  puts 'parameters:'
  puts "  location: #{m[1]}"
  puts "  loctype: #{m[1]}-#{m[2]}"
  puts "  nodetype: #{m[2]}"
  puts "  nodeindex: #{idx}"
else
  exit 1
end
