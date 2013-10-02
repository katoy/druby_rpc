# -*- coding: utf-8 -*-

require 'drb/drb'

DRb.start_service

rpc = DRbObject.new(nil, 'druby://localhost:24680')

id = ARGV[0]
rpc.exec_async(id)
puts "id: #{}#{rpc.result}"

# 呼び出し例：
# ------------
#
# $ ruby rpc_async.rb ls
# id: {:id=>"3"}
#
# $ ruby rpc_async_log.rb 3
# id=3:  {:status=>:finish, :cmd=>"ls", :start=>2013-10-03 01:41:46 +0900, :end=>2013-10-03 01:41:46 +0900,
# :ret=>#<Process::Status: pid 17442 exit 0>, :out=>"rpc_async.rb\nrpc_async_log.rb\nrpc_sync.rb\nserver.rb\n", :err=>""}
#
# $ ruby rpc_async_log.rb 3
# id=3:  -- no log data


