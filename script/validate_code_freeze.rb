#!/usr/bin/env ruby

require 'yaml'
require 'time'

code_freezes = YAML.load_file('code_freeze.yaml')

if code_freezes.nil?
  return
end

code_freezes.each do | code_freeze |
  if code_freeze["reason"].nil?
    puts "Code freeze missing a reason field."
    exit 1
  end
  begin
    Time.strptime(code_freeze["start_time"], '%Y-%m-%dT%H:%M')
    Time.strptime(code_freeze["end_time"], '%Y-%m-%dT%H:%M')
  rescue
    puts "Invalid code freeze start or end time. See the comment at the top of code_freeze.yaml for the expected format."
    exit 1
  end
end

exit 0
