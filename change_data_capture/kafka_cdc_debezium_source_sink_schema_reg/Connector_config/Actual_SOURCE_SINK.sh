cat << EOF > JdbcSinkConnector.json
{
  "name": "JdbcSinkConnector",
  "config": {
    "connector.class": "io.debezium.connector.jdbc.JdbcSinkConnector",
    "table.name.format": "test_table",
    "errors.log.include.messages": "true",
    "connection.password": "postgres",
    "primary.key.mode": "record_key",
    "tasks.max": "1",
    "connection.username": "postgres",
    "topics.regex": "postgres_test_db\\.public\\..*",
    "value.converter.schema.registry.url": "http://schema-registry:8081",
    "delete.enabled": "true",
    "schema.evolution": "basic",
    "errors.tolerance": "none",
    "primary.key.fields": "id",
    "connection.url": "jdbc:postgresql://postgres-sink:5432/test_sink_db",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "insert.mode": "upsert",
    "errors.log.enable": "true",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://schema-registry:8081"
  }
}
EOF
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d @JdbcSinkConnector.json /api/kafka-connect-1/connectors

cat << EOF > PostgresConnector.json
{
  "name": "PostgresConnector",
  "config": {
    "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
    "database.user": "postgres",
    "database.dbname": "test_source_db",
    "slot.name": "debezium_slot",
    "slot.drop.on.stop": "false",
    "tasks.max": "1",
    "database.port": "5432",
    "plugin.name": "pgoutput",
    "key.converter.schemas.enable": "true",
    "value.converter.schema.registry.url": "http://schema-registry:8081",
    "topic.prefix": "postgres_test_db",
    "decimal.handling.mode": "double",
    "database.hostname": "postgres-source",
    "database.password": "postgres",
    "value.converter.schemas.enable": "true",
    "table.include.list": "public.test_table",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://schema-registry:8081",
    "snapshot.mode": "initial"
  }
}
EOF
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d @PostgresConnector.json /api/kafka-connect-1/connectors
