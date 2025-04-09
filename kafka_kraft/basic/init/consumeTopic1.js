const { Kafka } = require('kafkajs');

// Configure Kafka client with three brokers
const kafka = new Kafka({
  clientId: 'my-kafka-consumer',
  brokers: ['localhost:9094'], // Replace with actual broker addresses
});

// Create a consumer instance
const consumer = kafka.consumer({ groupId: 'my-consumer-group' });

const consumeTopic1 = async () => {
  try {
    // Connect to the consumer
    await consumer.connect();

    // Subscribe to the topic
    await consumer.subscribe({ topic: 'topic1', fromBeginning: true });

    // Consume messages from the topic
    await consumer.run({
      eachMessage: async ({ topic, partition, message }) => {
        console.log(`Received message from topic ${topic} partition ${partition}:`);
        console.log(`  Value: ${message.value.toString()}`);
        console.log(`  Timestamp: ${message.timestamp}`);
      },
    });
  } catch (error) {
    console.error('Error consuming messages:', error);
  }
};

// Execute the function
consumeTopic1();
