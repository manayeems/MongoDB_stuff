@echo on
echo

start cmd /c mongod --configsvr --dbpath data/config1 --port 2011 --replSet rs0  --bind_ip localhost   
start cmd /c mongod --configsvr --dbpath data/config2 --port 2012 --replSet rs0  --bind_ip localhost   
start cmd /c mongod --configsvr --dbpath data/config3 --port 2013 --replSet rs0  --bind_ip localhost   
 
echo

start cmd /c mongod --shardsvr --replSet shard1rs --port 20010 --dbpath data/shard1/rs1  --bind_ip localhost      
start cmd /c mongod --shardsvr --replSet shard1rs --port 20011 --dbpath data/shard1/rs2  --bind_ip localhost      
start cmd /c mongod --shardsvr --replSet shard1rs --port 20012 --dbpath data/shard1/rs3    --bind_ip localhost    

echo

start cmd /c mongod --shardsvr --replSet shard2rs --port 20013 --dbpath data/shard2/rs1  --bind_ip localhost      
start cmd /c mongod --shardsvr --replSet shard2rs --port 20014 --dbpath data/shard2/rs2  --bind_ip localhost      
start cmd /c mongod --shardsvr --replSet shard2rs --port 20015 --dbpath data/shard2/rs3    --bind_ip localhost    

echo

start cmd /c mongod --shardsvr --replSet shard3rs --port 20016 --dbpath data/shard3/rs1    --bind_ip localhost   
start cmd /c mongod --shardsvr --replSet shard3rs --port 20017 --dbpath data/shard3/rs2      --bind_ip localhost   
start cmd /c mongod --shardsvr --replSet shard3rs --port 20018 --dbpath data/shard3/rs3    --bind_ip localhost   

echo

start cmd /c mongod --shardsvr --replSet shard4rs --port 20019 --dbpath data/shard4/rs1    --bind_ip localhost   
start cmd /c mongod --shardsvr --replSet shard4rs --port 20020 --dbpath data/shard4/rs2      --bind_ip localhost   
start cmd /c mongod --shardsvr --replSet shard4rs --port 20021 --dbpath data/shard4/rs3    --bind_ip localhost   
 

start cmd /c mongos --configdb "rs0/localhost:2011,localhost:2012,localhost:2013" --logpath data/logs/log.mongos0 --port 27200    

