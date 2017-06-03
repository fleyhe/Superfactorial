Superfactorial é um repositório para teste de estresse aos bancos de dados
NoSQL, SQL e comparativo com buscas diretas ao sistema de arquivos.

# MongoDB

## Instalando dependências

  Para instalar as dependências no sistema Ubuntu
é necessário a execução do seguinte sh:

```shellscript
sudo apt-get install mongodb
sudo service mongodb start
sudo gem install mongo
```

## Setup inicial do banco

```ruby
mongo superfactorial
db.fat.insert({n: "0", f: "1"})
db.fat.insert({n: "1", f: "1"})
db.sfat.insert({n: "0", f: "1"})
db.sfat.insert({n: "1", f: "1"})
```

## Busca no banco e funcionamento

```ruby
require 'mongo'
client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'superfactorial')
docs = client[:fat].find({:n => "0"}).to_a
=> [{"_id"=>BSON::ObjectId('5931e4070f89c47b29c95e0e'), "n"=>"0", "f"=>"1"}]
docs[0]["f"].to_i
=> 1

client.close
```

```ruby
f = fat(3)
=> 6
doc = { :_id => BSON::ObjectId.new, :n => 3.to_s, :f => f.to_s }
client[:fat].insert_one doc

client.close
```

# Mysql

## Startup schema

```sql
CREATE SCHEMA `superfactorial` ;

CREATE TABLE `superfactorial`.`fat` (
  `n` INT NOT NULL,
  `f` LONGTEXT NOT NULL,
  PRIMARY KEY (`n`));

CREATE TABLE `superfactorial`.`sfat` (
  `n` INT NOT NULL,
  `f` LONGTEXT NULL,
  PRIMARY KEY (`n`));


delete from fat;
delete from sfat;

insert into fat values (0, "1");
insert into fat values (1, "1");
insert into sfat values (0, "1");
insert into sfat values (1, "1");

```
