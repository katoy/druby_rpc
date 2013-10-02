# -*- coding: utf-8 -*-

require 'drb/drb'

DRb.start_service

rpc = DRbObject.new(nil, 'druby://localhost:24680')

rpc.exec_sync(ARGV[0])
puts "#{rpc.result}"
puts "処理時間：#{rpc.result[:end] - rpc.result[:start]} 秒"

# 呼び出し例：
# ------------
#  $ ruby client.rb ls
# {:status=>:finish, :cmd=>"ls", :start=>2013-10-03 01:38:07 +0900, :end=>2013-10-03 01:38:08 +0900,
#  :ret=>#<Process::Status: pid 17366 exit 0>, :out=>"rpc_async.rb\nrpc_async_log.rb\nrpc_sync.rb\nserver.rb\n", :err=>""}
#
#  $ ruby client.rb "sleep 5; ls"
# {:status=>:finish, :cmd=>"sleep 5; ls", :start=>2013-10-03 01:39:20 +0900, :end=>2013-10-03 01:39:25 +0900,
#  :ret=>#<Process::Status: pid 17394 exit 0>, :out=>"rpc_async.rb\nrpc_async_log.rb\nrpc_sync.rb\nserver.rb\n", :err=>""}


