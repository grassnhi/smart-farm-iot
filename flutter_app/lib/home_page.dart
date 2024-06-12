import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/animated_switch.dart';
import 'package:flutter_app/automatic_page.dart';
import 'package:flutter_app/history_page.dart';
import 'package:flutter_app/login_page.dart';
import 'global_data_widget.dart';
import 'main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/noti_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLedOn = false;
  bool isPumpInOn = true;
  bool isPumpOutOn = true;
  bool isMixer1Pressed = false;
  bool isMixer2Pressed = false;
  bool isMixer3Pressed = false;
  bool isArea1Pressed = false;
  bool isArea2Pressed = false;
  bool isArea3Pressed = false;

  String _getCurrentTimestamp() {
    final now = DateTime.now().toUtc().add(Duration(hours: 7)); // GMT+7
    final formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    return '${formatter.format(now)} GMT+0700';
  }

  void _onMixer1Pressed() {
    setState(() {
      isMixer1Pressed = !isMixer1Pressed;
    });
    var message = [
      {
        "action": "control actuator",
        "timestamp": _getCurrentTimestamp(),
        "actuator_id": "mixer_0001",
        "data": isMixer1Pressed ? "1" : "0",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  void _onMixer2Pressed() {
    setState(() {
      isMixer2Pressed = !isMixer2Pressed;
    });
    var message = [
      {
        "action": "control actuator",
        "timestamp": _getCurrentTimestamp(),
        "actuator_id": "mixer_0002",
        "data": isMixer2Pressed ? "1" : "0",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  void _onMixer3Pressed() {
    setState(() {
      isMixer3Pressed = !isMixer3Pressed;
    });
    var message = [
      {
        "action": "control actuator",
        "timestamp": _getCurrentTimestamp(),
        "actuator_id": "mixer_0003",
        "data": isMixer3Pressed ? "1" : "0",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  void _onArea1Pressed() {
    setState(() {
      isArea1Pressed = !isArea1Pressed;
    });
    var message = [
      {
        "action": "control actuator",
        "timestamp": _getCurrentTimestamp(),
        "actuator_id": "area_0001",
        "data": isArea1Pressed ? "1" : "0",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  void _onArea2Pressed() {
    setState(() {
      isArea2Pressed = !isArea2Pressed;
    });
    var message = [
      {
        "action": "control actuator",
        "timestamp": _getCurrentTimestamp(),
        "actuator_id": "area_0002",
        "data": isArea2Pressed ? "1" : "0",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  void _onArea3Pressed() {
    setState(() {
      isArea3Pressed = !isArea3Pressed;
    });
    var message = [
      {
        "action": "control actuator",
        "timestamp": _getCurrentTimestamp(),
        "actuator_id": "area_0003",
        "data": isArea3Pressed ? "1" : "0",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  void _onPumpInPressed(bool newValue) {
    setState(() {
      isPumpInOn = newValue;
    });
    var message = [
      {
        "action": "control actuator",
        "timestamp": _getCurrentTimestamp(),
        "actuator_id": "pump_in_0001",
        "data": isPumpInOn ? "0" : "1",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  void _onPumpOutPressed(bool newValue) {
    setState(() {
      isPumpOutOn = newValue;
    });
    var message = [
      {
        "action": "control actuator",
        "timestamp": _getCurrentTimestamp(),
        "actuator_id": "pump_out_0001",
        "data": isPumpOutOn ? "0" : "1",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Row(
                      children: [
                        Text(
                          'IoT',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 135,
                          child: Icon(
                            Icons.bar_chart_rounded,
                            size: 28,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.notifications),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotiPage(),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 0),
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/field.png',
                        scale: 0.8,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Center(
                      child: Text(
                        'Smart farm',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _roundedButton(title: 'MANUAL', isActive: true),
                        _roundedButton(
                          title: 'AUTOMATIC',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AutomaticPage(),
                              ),
                            );
                          },
                        ),
                        _roundedButton(
                          title: 'HISTORY',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _cardMenu(
                          title: 'Mixer 1',
                          icon: 'assets/images/mixer1.png',
                          color: isMixer1Pressed
                              ? Color.fromARGB(255, 37, 187, 75)
                              : Colors.grey,
                          fontColor: Colors.white,
                          onTap: _onMixer1Pressed,
                        ),
                        const SizedBox(width: 16),
                        _cardMenu(
                          title: 'Mixer 2',
                          icon: 'assets/images/mixer2.png',
                          color: isMixer2Pressed
                              ? Color.fromARGB(255, 37, 187, 75)
                              : Colors.grey,
                          fontColor: Colors.white,
                          onTap: _onMixer2Pressed,
                        ),
                        const SizedBox(width: 16),
                        _cardMenu(
                          title: 'Mixer 3',
                          icon: 'assets/images/mixer1.png',
                          color: isMixer3Pressed
                              ? Color.fromARGB(255, 37, 187, 75)
                              : Colors.grey,
                          fontColor: Colors.white,
                          onTap: _onMixer3Pressed,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _cardMenu(
                          title: 'Area 1',
                          icon: 'assets/images/area1.png',
                          color: isArea1Pressed
                              ? Color.fromARGB(255, 37, 187, 75)
                              : Colors.grey,
                          fontColor: Colors.white,
                          onTap: _onArea1Pressed,
                        ),
                        const SizedBox(width: 16),
                        _cardMenu(
                          title: 'Area 2',
                          icon: 'assets/images/area3.png',
                          color: isArea2Pressed
                              ? Color.fromARGB(255, 37, 187, 75)
                              : Colors.grey,
                          fontColor: Colors.white,
                          onTap: _onArea2Pressed,
                        ),
                        const SizedBox(width: 16),
                        _cardMenu(
                          title: 'Area 3',
                          icon: 'assets/images/area2.png',
                          color: isArea3Pressed
                              ? Color.fromARGB(255, 37, 187, 75)
                              : Colors.grey,
                          fontColor: Colors.white,
                          onTap: _onArea3Pressed,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedSwitch(
                          isOn: isPumpInOn,
                          onTap: _onPumpInPressed,
                          onText: 'PUMP IN',
                          offText: 'PUMP IN',
                        ),
                        AnimatedSwitch(
                          isOn: isPumpOutOn,
                          onTap: _onPumpOutPressed,
                          onText: 'PUMP OFF',
                          offText: 'PUMP OFF',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _dataBox(
                          title: 'Temperature',
                          data: Provider.of<GlobalData>(context).temperature,
                          icon: Icons.thermostat,
                        ),
                        const SizedBox(width: 16),
                        _dataBox(
                          title: 'Humidity',
                          data: Provider.of<GlobalData>(context).humidity,
                          icon: Icons.water_drop,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardMenu({
    required String title,
    required String icon,
    VoidCallback? onTap,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Image.asset(
                icon,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: fontColor,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roundedButton({
    required String title,
    bool isActive = false,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      height: 60,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.indigo : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.indigo),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _dataBox({
    required String title,
    required String data,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.black, width: 1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.indigo),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              data,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
