#!/usr/bin/ruby
# Stress test with superfactorial for MongoDB.

# clear mongoDB
system("mongo superfactorial < resetmongo")


require 'mongo'

# Start the client
Mongo::Logger.logger.level = ::Logger::FATAL
$client = Mongo::Client.new [ '127.0.0.1:27017' ], :database => 'superfactorial'

# Factorial function
def fat n
  puts("buscando fat(#{n})")
  return 1 if n == 1 or n == 0
  f = findFat(n)
  if f == nil
    f = fat(n-1)*n
    insertFat n, f
    return f
  end
  return f
end

# Superfactorial function
def sfat n
  puts("buscando sfat(#{n})")
  return 1 if n == 1 or n == 0
  f = findSfat(n)
  if f == nil
    f = sfat(n-1)*fat(n)
    insertSfat n, f
    return f
  end
  return f
end

def insertFat n, f
  puts "Inserindo fat(#{n})"
  doc = { :_id => BSON::ObjectId.new, :n => n.to_s, :f => f.to_s }
  $client[:fat].insert_one doc
end

def insertSfat n, f
  puts "Inserindo sfat(#{n})"
  doc = { :_id => BSON::ObjectId.new, :n => n.to_s, :f => f.to_s }
  $client[:sfat].insert_one doc
end

def findFat n
  r = $client[:fat].find({:n => n.to_s}).to_a()[0]
  return nil if r == nil
  return r["f"].to_i
end

def findSfat n
  r = $client[:sfat].find({:n => n.to_s}).to_a()[0]
  return nil if r == nil
  return r["f"].to_i
end


sfat(1000)
