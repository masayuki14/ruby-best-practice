#!/usr/bin/ruby
# coding; utf-8

require 'socket'

# usage:
#
# server = Server.new
# server.handle(/hello/i) { "Hello from server at #{Time.now}" }
# server.handle(/goodbye/i) { "Good bye from server at #{Time.now}" }
# server.handle(/name is (\w+)/) { |m| "Nice to meet you #{m[1]}!" }
# server.run
class Server

  def initialize(port=3333)
    @server = TCPServer.new('127.0.0.1', port)
    @handlers = {}
  end

  def handle(pattern, &block)
    @handlers[pattern] = block
  end

  def run
    while session = @server.accept
      msg = session.gets
      match = nil

      @handlers.each do |pattern, block|
        if match = msg.match(pattern)
          break session.puts(block.call(match))
        end
      end

      unless match
        session.puts "Server received unknown message: #{msg}"
      end
    end
  end

end
