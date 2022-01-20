#!/bin/bash

# http://www.cloudera.com/content/cloudera/en/documentation/cdh4/v4-2-0/CDH4-Installation-Guide/cdh4ig_topic_18_4.html

source "/vagrant/scripts/common.sh"
function setupKafka {
	echo "installing Kafka from remote"
	wget https://archive.apache.org/dist/kafka/2.8.1/kafka_2.12-2.8.1.tgz
	tar -xzf kafka_2.12-2.8.1.tgz
}

function startKafka {
	cd kafka_2.12-2.8.1
	#nohup bin/zookeeper-server-start.sh config/zookeeper.properties
	cp config/server.properties config/server-1.properties
	cp config/server.properties config/server-2.properties
	config/server-1.properties: broker.id=1, listeners=PLAINTEXT://:9093, log.dirs=/tmp/kafka-logs-1
	config/server-2.properties: broker.id=2, listeners=PLAINTEXT://:9094, log.dirs=/tmp/kafka-logs-2
	#nohup bin/kafka-server-start.sh config/server.properties && bin/kafka-server-start.sh config/server-1.properties && bin/kafka-server-start.sh config/server-2.properties &
	echo "now creating a topic with replication factor of 3"
	#nohup bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 3 --partitions 1 --topic my-replicated-topic
	echo "testing kafka"
	#echo -e "foo\nbar" > test.txt && > bin/connect-standalone.sh config/connect-standalone.properties config/connect-file-source.properties config/connect-file-sink.properties
	#more test.sink.txt
	#nohup bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic connect-test --from-beginning
}
echo "setting up kafka"
setupKafka
startKafka
