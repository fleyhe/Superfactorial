#!/usr/bin/ruby
# Stress test with superfactorial for MongoDB.

def fat n

end

def sfat n

end

def findFat n
  return $client[:fat].find {:n => n.to_s}.to_a[0][:f]
end

def findSfat n
  return $client[:sfat].find {:n => n.to_s}.to_a[0][:f]
end

require 'mongo'

begin
  $client = Mongo::Client.new [ '127.0.0.1:27017' ], :database => 'superfactorial'

rescue => e
  puts e
  $client.close
end
