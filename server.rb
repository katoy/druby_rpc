
# See http://d.hatena.ne.jp/gtaka555/20081124/p3

require 'drb/drb'
require 'open3'

class Runner

  attr_reader :result, :logs

  def initialize
    @result = {}
    @log = {}
    @id = 0
  end

  def exec_sync(cmd)
    startTime = endTime = nil
    begin
      startTime = Time.new
      o, e, ret = Open3.capture3(cmd)
      endTime = Time.new
      @result = {status: :"finish", cmd: cmd, start: startTime, end: endTime, ret: ret, out: o, err: e}
    rescue => e
      endTime = Time.new
      @result = {status: :"finish", cmd: cmd, start: startTime, end: endTime, ret: ret, out: o, err: e}
    end
  end

  def exec_async(cmd)
    @id += 1
    id = @id.to_s
    @log[id] = {status: "running", cmd: cmd, starTime: Time.new}

    Thread.new do
      @log[id] = exec_sync(cmd)
    end

    @result = {id: id}
  end

  def exec_async_log(id)
    id = id.to_s
    @result = @log[id]
    @log.delete(id) if @result and @result[:status] == :"finish"
  end
end

DRb.start_service('druby://localhost:24680', Runner.new)
DRb.thread.join

