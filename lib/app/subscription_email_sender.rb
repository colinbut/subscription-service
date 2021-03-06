#!/usr/bin/env ruby

require 'bunny'

class SubscriptionEmailSender

  connection = Bunny.new
  channel = nil
  queue = nil

  def initialize()
    connection.start
    channel = connection.create_channel
    queue = channel.queue('email-queue')
  end

  def sendMessage(message)
    channel.default_exchange.publish(message, routing_key: queue.name)
    puts ' [x] Sent message to RabbitMQ'
    connection.close
  end
end
