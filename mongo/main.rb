#!/usr/bin/ruby
# Stress test with superfactorial for MongoDB.

def fat n

end

def sfat n

end


require 'mongo'

begin
  $client = Mongo::Client.new [ '127.0.0.1:27017' ], :database => 'superfactorial'
  
rescue => e
  puts e
  $client.close
end
