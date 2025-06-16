#!/usr/bin/env ruby

require 'yaml'
require 'tzinfo'
require 'time'

tz = TZInfo::Timezone.get('America/Los_Angeles')
now = tz.local_to_utc(tz.utc_to_local(Time.now.utc))

code_freezes = YAML.load_file('code_freeze.yaml')

if code_freezes.nil?
  return
end

code_freezes.each do | code_freeze |
  start_local = Time.strptime(code_freeze["start_time"], '%Y-%m-%dT%H:%M')
  end_local = Time.strptime(code_freeze["end_time"], '%Y-%m-%dT%H:%M')

  start_time = tz.local_to_utc(start_local)
  end_time = tz.local_to_utc(end_local)

  # if now.between?(start_date, end_date)
  if (start_time..end_time).cover?(now)
    puts "frozen for #{code_freeze["reason"]} - #{tz.utc_to_local(Time.now.utc)} is between #{start_local} and #{end_local}"
    exit 1
  end
end

exit 0
