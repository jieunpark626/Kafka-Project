from kafka import KafkaProducer

producer = KafkaProducer(
    bootstrap_servers='localhost:9092',
    value_serializer=lambda v: v.encode('utf-8')
)
messages = [
    "test01 : kafka test 01",
    "test02 : kafka test 02",
    "test03 : kafka test 03"
]
topic = 'my-topic'
for message in messages:
    producer.send(topic, value=message)
    print(f"Producer Sent: {message}")
producer.flush()
producer.close()
