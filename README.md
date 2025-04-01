# Kafka-Project

## How to run
```
docker compose up # 데이터 흐름: Kafka -> Prometheus -> InfluxDB -> Grafana
./run_kafka.sh start # 여기서 JMX 같이 띄워줌
./kafka_src/examples/bin/java-producer-consumer-demo.sh 1000
```

- Grafana (localhost:3000) 로 이동
- Prometheus Datasource 추가 (localhost:9090)
- 시각화 대시보드 구성

### Kafka가 무엇인지
...

### 왜 필요한지
...

### Kafka Ecosystem
...

#### Producer
...

#### Consumer
...

#### Broker
...

#### Zookeeper
...

### Kafka 동작 원리

Apache Kafka는 분산 메시징 시스템으로, 대규모 실시간 데이터 스트리밍을 처리하기 위해 설계되었습니다. Kafka는 Producer가 데이터를 특정 topic에 발행하고, Consumer 가 해당 토픽에서 데이터를 구독하여 처리하는 방식으로 동작합니다. 토픽은 여러 partition 로 나뉘어 병렬 처리를 지원하며, 각 파티션은 브로커에 저장됩니다.

Kafka는 broker 들이 클러스터로 구성되며, 각 브로커는 토픽의 일부 파티션을 담당합니다. Leader-Follower 구조를 사용해 파티션의 리더가 모든 읽기/쓰기 작업을 처리하고, 팔로워는 리더의 데이터를 복제해 장애 복구 시 사용됩니다. Kafka는 메시지를 디스크에 저장하고, Consume 이 완료된 메시지도 일정 기간 동안 보관하여 높은 내구성과 확장성을 제공합니다.
