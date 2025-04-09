const { Kafka } = require('kafkajs');

// Configure Kafka client with three brokers
const kafka = new Kafka({
  clientId: 'my-kafka-client',
  brokers: ['localhost:9094'], // Replace with actual broker addresses
});

// Create a producer instance
const producer = kafka.producer();

const publishMessage = async () => {
  try {
    // Connect to the producer
    await producer.connect();

    // Define the topic and message
    const topic = 'topic1'; // Use one of the topics created earlier
    const messages = [
      { value: 'Hello, Kafka!' },
      { value: 'This is another message.' },
    ];

    // Send messages to the topic
    await producer.send({
      topic,
      messages,
    });

    console.log(`Messages published to topic ${topic} successfully.`);
  } catch (error) {
    console.error('Error publishing messages:', error);
  } finally {
    await producer.disconnect();
  }
};

// Execute the function
publishMessage();
