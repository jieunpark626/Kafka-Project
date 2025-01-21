from kafka import KafkaConsumer
topic = 'my-topic'
consumer = KafkaConsumer(
    topic,
    bootstrap_servers='localhost:9092',
    group_id='my-consumer-group',
    value_deserializer=lambda m: m.decode('utf-8'),
    enable_auto_commit=False # 자동 커밋 비활성화
)

for message in consumer:
    print(f"Consumer Received: {message.value}")

consumer.commit()
