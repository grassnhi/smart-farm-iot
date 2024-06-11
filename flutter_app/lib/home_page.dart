import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/animated_switch.dart';
import 'package:flutter_app/automatic_page.dart';
import 'package:flutter_app/login_page.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLedOn = false;
  bool isPumpOn = false;
  bool isPumpIn = true;
  bool isMixer1Pressed = false;
  bool isMixer2Pressed = false;
  bool isMixer3Pressed = false;
  bool isArea1Pressed = false;
  bool isArea2Pressed = false;
  bool isArea3Pressed = false;

  void _onMixer1Pressed() {
    // TODO: Implement the mixer 1 button press logic
    // Message = [
    //   {
    //     "action": "control actuator",
    //     "actuator_id": "mixer_0001",
    //     "data" : "1"
    //   }
    // ]
    setState(() {
      isMixer1Pressed = !isMixer1Pressed;
    });
    var message = [
      {
        "action": "control actuator",
        "actuator_id": "mixer_0001",
        "data": isMixer1Pressed ? "1" : "0",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  void _onMixer2Pressed() {
    // TODO: Implement the mixer 2 button press logic
    // The same with mixer 1
    setState(() {
      isMixer2Pressed = !isMixer2Pressed;
    });
    var message = [
      {
        "action": "control actuator",
        "actuator_id": "mixer_0002",
        "data": isMixer2Pressed ? "1" : "0",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  void _onMixer3Pressed() {
    // TODO: Implement the mixer 3 button press logic
    // the same with mixer 1
    setState(() {
      isMixer3Pressed = !isMixer3Pressed;
    });
    var message = [
      {
        "action": "control actuator",
        "actuator_id": "mixer_0003",
        "data": isMixer3Pressed ? "1" : "0",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  void _onArea1Pressed() {
    // TODO: Implement the area 1 button press logic
    // The same with mixer 1 but ID = area_0001
    setState(() {
      isArea1Pressed = !isArea1Pressed;
    });
    var message = [
      {
        "action": "control actuator",
        "actuator_id": "area_0001",
        "data": isArea1Pressed ? "1" : "0",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  void _onArea2Pressed() {
    // TODO: Implement the area 2 button press logic
    setState(() {
      isArea2Pressed = !isArea2Pressed;
    });
    var message = [
      {
        "action": "control actuator",
        "actuator_id": "area_0002",
        "data": isArea2Pressed ? "1" : "0",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  void _onArea3Pressed() {
    // TODO: Implement the area 3 button press logic
    setState(() {
      isArea3Pressed = !isArea3Pressed;
    });
    var message = [
      {
        "action": "control actuator",
        "actuator_id": "area_0003",
        "data": isArea3Pressed ? "1" : "0",
      }
    ];
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
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
                  SizedBox(
                    width: 40, // Adjust the width as needed
                    height: 40, // Adjust the height as needed
                    child: IconButton(
                      iconSize: 30, // Adjust the icon size as needed
                      icon: const Icon(Icons.logout),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                    ),
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
                        scale: 1.2,
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
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _roundedButton(title: 'MANUAL', isActive: true),
                        _roundedButton(
                          title: 'AUTOMATIC',
                          onPressed: () {
                            // Navigate to automatic page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AutomaticPage(),
                              ),
                            );
                          },
                        ),
                        _roundedButton(
                          title: 'HISTORY',
                          onPressed: () {
                            // Navigate to automatic page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AutomaticPage(),
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
                        const SizedBox(width: 16), // Add distance
                        _cardMenu(
                          title: 'Mixer 2',
                          icon: 'assets/images/mixer2.png',
                          color: isMixer2Pressed
                              ? Color.fromARGB(255, 37, 187, 75)
                              : Colors.grey,
                          fontColor: Colors.white,
                          onTap: _onMixer2Pressed,
                        ),
                        const SizedBox(width: 16), // Add distance
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
                        const SizedBox(width: 16), // Add distance
                        _cardMenu(
                          title: 'Area 2',
                          icon: 'assets/images/area3.png',
                          color: isArea2Pressed
                              ? Color.fromARGB(255, 37, 187, 75)
                              : Colors.grey,
                          fontColor: Colors.white,
                          onTap: _onArea2Pressed,
                        ),
                        const SizedBox(width: 16), // Add distance
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
                    const SizedBox(height: 20), // Add spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedSwitch(
                          isPumpIn: isPumpIn,
                          onTap: (bool newValue) {
                            setState(() {
                              isPumpIn = newValue; // Update the pump state
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
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
            border: Border.all(color: Colors.black, width: 1), // Add border
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
      height: 60, // Adjust the height as needed
      // width: 150,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8), // Add vertical margin
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
}
