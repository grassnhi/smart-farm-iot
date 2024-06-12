from datetime import datetime
from MQTT_Helper import *
from physic import *

class HardwareManager:
    def __init__(self):
        # Setting up the MQTT client
        broker_host = "mqtt.ohstem.vn"
        username = "smarfarm_iot"
        password = ""
        client_id = "RaspCM4"
        self.subTopic = 'smartfarm_iot/feeds/V20'
        self.pubTopic = 'smartfarm_iot/feeds/V15'


        self.mqtt_helper = MQTTClientHelper(broker_host, username, password, client_id)
        self.mqtt_helper.connect()

        self.mqtt_helper.subscribe(self.subTopic)
        self.hardware = Physic(False)
        self.onMessage = self.mqtt_helper.on_message

    def onMessage(self, client, userdata, msg):
        if msg.topic == self.subTopic:
            payload = json.loads(msg.payload.decode())
            print(f"Received message on topic {msg.topic}: {payload}")
            actuator_id = payload[0]['actuator_id']
            data = payload[0]['data'] == "1"
            action = payload[0]['action']
            if action == "control actuator":
                print("Actuator ID: ", actuator_id, " turn ", "ON" if data else "OFF")
                if actuator_id == "mixer_0001":
                    self.hardware.setActuators(2, data)
                elif actuator_id == "mixer_0002":
                    self.hardware.setActuators(3, data)
                elif actuator_id == "mixer_0003":
                    self.hardware.setActuators(4, data)
                # elif actuator_id == "area_0001":
                #     self.hardware.setActuators(5, data)
                # elif actuator_id == "area_0002":
                #     self.hardware.setActuators(6, data)
                # elif actuator_id == "area_0003":
                #     self.hardware.setActuators(7, data)
                # elif actuator_id == "pump_in_0001":
                #     self.hardware.setActuators(8, data)
                # elif actuator_id == "pump_out_0001":
                #     self.hardware.setActuators(9, data)
    def readSensorsAndPublish(self):
        # Make temperature to String and take only 2 decimal
        temperature = str(round(self.hardware.readSensors('soil_temperature'), 2))
        time.sleep(3)
        moisture = str(round(self.hardware.readSensors('soil_moisture'), 2))
        time.sleep(3)
        #  data =
        #  [
        #   {
        #     "action": "update sensor",
        #     "timestamp":"11-06-2024 22:17:27 GMT+0700",
        #     "data": {
        #       "temperature": "25",
        #       "humidity": "65"
        #     }
        #   }
        # ]
        # get current time GMT +7
        print("Updating sensor data...")
        timeStamp = str(datetime.now().strftime("%d-%m-%Y %H:%M:%S GMT+0700"))
        data = [
            {
                "action": "update sensor",
                "timestamp": timeStamp,
                "data": {
                    "temperature": temperature,
                    "humidity": moisture
                }
            }
        ]
        self.mqtt_helper.publish(self.pubTopic, data)
