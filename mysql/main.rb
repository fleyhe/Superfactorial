#!/usr/bin/ruby
# Stress test with superfactorial for MongoDB.

require 'mysql2'

# Start the client
$client = Mysql2::Client.new(:host => "localhost",
                            :database => "superfactorial",
                            :username => "root",
                            :password => "root")

# clear MySQL
$client.query("delete from fat;")
$client.query("delete from sfat;")

$client.query("insert into fat values (0, '1');")
$client.query("insert into fat values (1, '1');")
$client.query("insert into sfat values (0, '1');")
$client.query("insert into sfat values (1, '1');")

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
  $client.query("INSERT INTO fat VALUES (#{n},'#{f}')")
end

def insertSfat n, f
  puts "Inserindo sfat(#{n})"
  $client.query("INSERT INTO sfat VALUES (#{n},'#{f}')")
end

def findFat n
  r = $client.query("SELECT * FROM fat WHERE n = '#{n}'").to_a()[0]
  return nil if r == nil
  return r["f"].to_i
end

def findSfat n
  r = $client.query("SELECT * FROM sfat WHERE n = '#{n}'").to_a()[0]
  return nil if r == nil
  return r["f"].to_i
end


sfat(1000)
