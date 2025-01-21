#!/bin/bash

# Kafka 설치 경로 (Kafka를 다운로드하고 압축을 해제한 디렉토리 경로로 변경하세요)
KAFKA_DIR="./kafka_src"

# Kafka 로그 디렉토리
LOGS_DIR="$KAFKA_DIR/logs"

# Zookeeper 설정 파일
ZOOKEEPER_CONFIG="$KAFKA_DIR/config/zookeeper.properties"

# Kafka 서버 설정 파일
KAFKA_CONFIG="$KAFKA_DIR/config/server.properties"

# Kafka Broker 주소
BROKER="localhost:9092"

# 함수: Zookeeper 시작
start_zookeeper() {
    echo "Starting Zookeeper..."
    nohup $KAFKA_DIR/bin/zookeeper-server-start.sh $ZOOKEEPER_CONFIG > $LOGS_DIR/zookeeper.log 2>&1 &
    sleep 5
    echo "Zookeeper started. Logs: $LOGS_DIR/zookeeper.log"
}

# 함수: Kafka Broker 시작
start_kafka() {
    echo "Starting Kafka Broker..."
    nohup $KAFKA_DIR/bin/kafka-server-start.sh $KAFKA_CONFIG > $LOGS_DIR/kafka.log 2>&1 &
    sleep 10
    echo "Kafka Broker started. Logs: $LOGS_DIR/kafka.log"
}

# 함수: Kafka 토픽 생성
create_topic() {
    local topic_name=$1
    echo "Creating Kafka topic: $topic_name"
    $KAFKA_DIR/bin/kafka-topics.sh --create --topic "$topic_name" --bootstrap-server $BROKER --partitions 1 --replication-factor 1
    echo "Topic '$topic_name' created."
}

# 함수: 종료
stop_all() {
    echo "Stopping Kafka Broker..."
    $KAFKA_DIR/bin/kafka-server-stop.sh
    sleep 5
    echo "Stopping Zookeeper..."
    $KAFKA_DIR/bin/zookeeper-server-stop.sh
    echo "All services stopped."
}

# 스크립트 실행 옵션
case $1 in
    start)
        start_zookeeper
        start_kafka
        ;;
    stop)
        stop_all
        ;;
    create-topic)
        if [ -z "$2" ]; then
            echo "Usage: $0 create-topic <topic_name>"
            exit 1
        fi
        create_topic "$2"
        ;;
    *)
        echo "Usage: $0 {start|stop|create-topic <topic_name>}"
        exit 1
        ;;
esac
