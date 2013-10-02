# -*- coding: utf-8 -*-

require 'drb/drb'

DRb.start_service

rpc = DRbObject.new(nil, 'druby://localhost:24680')

ARGV.each { |id|
  rpc.exec_async_log(id)
  if rpc.result
    puts "id=#{id}:  #{rpc.result}"
  else
    puts "id=#{id}:  -- no log data"
  end
}

