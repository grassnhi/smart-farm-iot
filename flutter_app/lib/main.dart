import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:flutter_app/mqtt_helper.dart';
import 'login_page.dart';
import 'dart:convert'; // For JSON decoding
import 'home_page.dart';
// Global variable of mqtt for late using
late MQTTHelper global_mqttHelper;

class MqttManager {
  /* MQTT information:
  MQTT_USERNAME = "smarfarm_iot"
  MQTT_PASSWORD = " "
  MQTT_PUB_TOPIC = "smartfarm_iot/feeds/V20"
  MQTT_SUB_TOPIC = "smartfarm_iot/feeds/V15"
 */
  MqttManager() {
    const String server = "mqtt.ohstem.vn";
    const String username = "smarfarm_iot";
    const String password = "";
    const List<String> subTopics = ["smartfarm_iot/feeds/V20", "smartfarm_iot/feeds/V15"];
    const String pubTopic = "smartfarm_iot/feeds/V15";

    global_mqttHelper = MQTTHelper(server, "flutter_client", username, password);
    global_mqttHelper.onConnectedCallback = () {
      for (String topic in subTopics) {
        global_mqttHelper.subscribe(topic);
      }
    };
    global_mqttHelper.initializeMQTTClient();
  }

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure MqttManager is initialized once
    MqttManager();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const LoginPage(),
      home: const MyHomePage(title: 'IOT SMART FARM APP'),

    );
  }
}
