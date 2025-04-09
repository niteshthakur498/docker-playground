const { Kafka } = require('kafkajs');

// Configure Kafka client with three brokers
const kafka = new Kafka({
  clientId: 'my-kafka-client',
  brokers: ['localhost:9094'], // Replace with actual broker addresses
});

const admin = kafka.admin();

const createTopics = async () => {
  try {
    // Connect to the admin client
    await admin.connect();

    // Define topics to be created
    const topics = [
      { topic: 'topic1', numPartitions: 3, replicationFactor: 1 },
      { topic: 'topic2', numPartitions: 3, replicationFactor: 1 },
    ];

    // Create topics in the cluster
    await admin.createTopics({
      topics,
    });

    console.log('Topics created successfully:', topics.map(t => t.topic));
  } catch (error) {
    console.error('Error creating topics:', error);
  } finally {
    await admin.disconnect();
  }
};

// Execute the function
createTopics();
