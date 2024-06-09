import 'package:flutter/material.dart';
import 'package:flutter_app/animated_switch.dart';
import 'package:flutter_app/automatic_page.dart';
import 'package:flutter_app/history_page.dart';
import 'package:flutter_app/login_page.dart';
import 'package:flutter_app/noti_page.dart';

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
                        scale: 1.0,
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
                            // Navigate to automatic page
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
                            // Navigate to automatic page
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
                          onTap: () {
                            setState(() {
                              isMixer1Pressed = !isMixer1Pressed;
                            });
                          },
                        ),
                        const SizedBox(width: 16), // Add distance
                        _cardMenu(
                          title: 'Mixer 2',
                          icon: 'assets/images/mixer2.png',
                          color: isMixer2Pressed
                              ? Color.fromARGB(255, 37, 187, 75)
                              : Colors.grey,
                          fontColor: Colors.white,
                          onTap: () {
                            setState(() {
                              isMixer2Pressed = !isMixer2Pressed;
                            });
                          },
                        ),
                        const SizedBox(width: 16), // Add distance
                        _cardMenu(
                          title: 'Mixer 3',
                          icon: 'assets/images/mixer1.png',
                          color: isMixer3Pressed
                              ? Color.fromARGB(255, 37, 187, 75)
                              : Colors.grey,
                          fontColor: Colors.white,
                          onTap: () {
                            setState(() {
                              isMixer3Pressed = !isMixer3Pressed;
                            });
                          },
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
                          onTap: () {
                            setState(() {
                              isArea1Pressed = !isArea1Pressed;
                            });
                          },
                        ),
                        const SizedBox(width: 16), // Add distance
                        _cardMenu(
                          title: 'Area 2',
                          icon: 'assets/images/area3.png',
                          color: isArea2Pressed
                              ? Color.fromARGB(255, 37, 187, 75)
                              : Colors.grey,
                          fontColor: Colors.white,
                          onTap: () {
                            setState(() {
                              isArea2Pressed = !isArea2Pressed;
                            });
                          },
                        ),
                        const SizedBox(width: 16), // Add distance
                        _cardMenu(
                          title: 'Area 3',
                          icon: 'assets/images/area2.png',
                          color: isArea3Pressed
                              ? Color.fromARGB(255, 37, 187, 75)
                              : Colors.grey,
                          fontColor: Colors.white,
                          onTap: () {
                            setState(() {
                              isArea3Pressed = !isArea3Pressed;
                            });
                          },
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
