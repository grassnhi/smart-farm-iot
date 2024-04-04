import paho.mqtt.client as mqtt
import time
import json

class MQTTClientHelper:
    def __init__(self, broker_host, username, password, client_id):
        self.broker_host = broker_host
        self.broker_port = 1883
        self.username = username
        self.password = password
        self.client_id = client_id
        self.client = mqtt.Client(client_id)
        self.client.username_pw_set(username, password)
        self.client.on_connect = self.on_connect
        self.client.on_message = self.on_message

    def on_connect(self, client, userdata, flags, rc):
        if rc == 0:
            print("Connected to MQTT Broker")
        else:
            print("Connection failed with code", rc)

    def on_message(self, client, userdata, msg):
        try:
            payload = json.loads(msg.payload.decode())
            print(f"Received message on topic {msg.topic}: {payload}")
            # Handle the received payload as needed
        except json.JSONDecodeError as e:
            print(f"Error decoding JSON: {e}")

    def connect(self):
        self.client.connect(self.broker_host, self.broker_port)
        self.client.loop_start()

    def subscribe(self, topic):
        self.client.subscribe(topic)
        print(f"Subscribed to topic: {topic}")

    def publish(self, topic, payload):
        try:
            payload_str = json.dumps(payload)
            self.client.publish(topic, payload_str)
            print(f"Published to topic {topic}: {payload}")
        except json.JSONDecodeError as e:
            print(f"Error encoding JSON: {e}")

    def disconnect(self):
        self.client.disconnect()
        self.client.loop_stop()
        print("Disconnected from MQTT Broker")

# Example usage:
if __name__ == "__main__":
    broker_host = "io.adafruit.com"
    username = "your_adafruit_username"
    password = "your_adafruit_aio_key"
    client_id = "your_unique_client_id"

    mqtt_helper = MQTTClientHelper(broker_host, username, password, client_id)
    mqtt_helper.connect()

    # Subscribe to a topic
    topic_to_subscribe = f"{username}/feeds/your_feed_name"
    mqtt_helper.subscribe(topic_to_subscribe)

    # Publish a message
    topic_to_publish = f"{username}/feeds/your_feed_name"
    message_to_publish = {"key": "value"}
    mqtt_helper.publish(topic_to_publish, message_to_publish)

    # Keep the program running
    while True:
        pass