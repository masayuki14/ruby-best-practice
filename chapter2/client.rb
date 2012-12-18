#!/usr/bin/ruby
# coding; utf-8

require 'socket'

# usage
#
# client = Client.new
# ["Hello", "My name is Paul", "Goodbye"].each do |msg|
#   puts client.send_message(msg)
# end
class Client

  def initialize(ip='127.0.0.1', port=3333)
    @ip, @port = ip, port
  end

  def send_message(msg)
    connection do |socket|
      socket.puts(msg)
      socket.gets
    end
  end

  def receive_message
    connection {|socket| socket.gets}
  end

private

  def connection
    socket = TCPSocket.new(@ip, @port)
    yield(socket)
  ensure
    socket.close if socket
  end

end
