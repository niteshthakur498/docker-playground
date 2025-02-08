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
    "topic.prefix": "postgres_test_db",
    "decimal.handling.mode": "double",
    "database.hostname": "postgres-source",
    "database.password": "postgres",
    "table.include.list": "public.test_table",
    "snapshot.mode": "initial"
  }
}
EOF
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d @PostgresConnector.json /api/kafka-connect-1/connectors