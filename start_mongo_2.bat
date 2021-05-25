@echo on
echo

start cmd /c mongod --configsvr --dbpath data/config1  --logpath data/logs/config1.log  --port 2011 --replSet rs0  --bind_ip localhost   
start cmd /c mongod --configsvr --dbpath data/config2  --logpath data/logs/config2.log  --port 2012 --replSet rs0  --bind_ip localhost   
start cmd /c mongod --configsvr --dbpath data/config3  --logpath data/logs/config3.log  --port 2013 --replSet rs0  --bind_ip localhost   
 
echo

start cmd /c mongod --shardsvr --replSet shard2rs --port 2004 --dbpath data/shard2/rs1  --logpath data/logs/shard2rs1.log  --bind_ip localhost      
start cmd /c mongod --shardsvr --replSet shard2rs --port 2005 --dbpath data/shard2/rs2  --logpath data/logs/shard2rs2.log  --bind_ip localhost      
start cmd /c mongod --shardsvr --replSet shard2rs --port 2006 --dbpath data/shard2/rs3  --logpath data/logs/shard2rs3.log    --bind_ip localhost    

echo

start cmd /c mongod --shardsvr --replSet shard3rs --port 2007 --dbpath data/shard3/rs1   --logpath data/logs/shard3rs1.log   --bind_ip localhost   
start cmd /c mongod --shardsvr --replSet shard3rs --port 2008 --dbpath data/shard3/rs2    --logpath data/logs/shard3rs2.log    --bind_ip localhost   
start cmd /c mongod --shardsvr --replSet shard3rs --port 2009 --dbpath data/shard3/rs3   --logpath data/logs/shard3rs3.log    --bind_ip localhost   

echo

start cmd /c mongod --shardsvr --replSet shard4rs --port 20015 --dbpath data/shard4/rs1    --logpath data/logs/shard4rs1.log   --bind_ip localhost   
start cmd /c mongod --shardsvr --replSet shard4rs --port 20016 --dbpath data/shard4/rs2    --logpath data/logs/shard4rs2.log   --bind_ip localhost   
start cmd /c mongod --shardsvr --replSet shard4rs --port 20017 --dbpath data/shard4/rs3    --logpath data/logs/shard4rs3.log  --bind_ip localhost   
 

start cmd /c mongos --configdb "rs0/localhost:2011,localhost:2012,localhost:2013" --logpath data/logs/log.mongos0 --port 27200    


