import 'dart:convert';

import 'package:flutter/material.dart';
import 'main.dart';

class Schedule {
  String name;
  String startTime;
  String endTime;
  int cycleTime;
  int flow1;
  int flow2;
  int flow3;
  bool isActive;

  Schedule({
    this.name = '',
    this.startTime = '',
    this.endTime = '',
    this.cycleTime = 0,
    this.flow1 = 0,
    this.flow2 = 0,
    this.flow3 = 0,
    this.isActive = false,
  });

  void _uploadSchedule() {
    /* Upload schedule to the server
      [
        {
          "action": "schedule",
          "timestamp":"11-06-2024 22:17:27 GMT+0700",
          "cycle": 5,
          "flow1": 20,
          "flow2": 10,
          "flow3": 20,
          "isActive": true,
          "schedulerName": "LỊCH TƯỚI 1",
          "startTime": "18:30",
          "stopTime": "18:40"
        }
    ]
  */
    var message = {
      "action": "schedule",
      "timestamp": getCurrentTimestamp(),
      "cycle": cycleTime,
      "flow1": flow1,
      "flow2": flow2,
      "flow3": flow3,
      "isActive": isActive,
      "schedulerName": name,
      "startTime": startTime,
      "stopTime": endTime
    };
    global_mqttHelper.publish("smartfarm_iot/feeds/V20", jsonEncode(message));

    //TODO: send message to firebase database

  }
  void _deleteSchedule() {
    flow1 = 0;
    flow2 = 0;
    flow3 = 0;
    cycleTime = 0;
    isActive = false;
    name = '';
    startTime = '';
    endTime = '';
  }
}


class AutomaticPage extends StatefulWidget {
  const AutomaticPage({Key? key});

  @override
  _AutomaticPageState createState() => _AutomaticPageState();
}

class _AutomaticPageState extends State<AutomaticPage> {
  bool isActive = false; // Variable to track the checkbox state
  Schedule schedule = Schedule();
  void _submitSchedule() {
    schedule._uploadSchedule();
    schedule._deleteSchedule();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Automatic Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Irrigation Scheduler',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Scheduler Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Start Time (mm:ss)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'End Time (mm:ss)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Cycle Time (minutes)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Flow 1 (seconds)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Flow 2 (seconds)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Flow 3 (seconds)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: isActive, // Set the value based on isActive variable
                    onChanged: (value) {
                      setState(() {
                        isActive = value ?? false; // Update isActive when checkbox state changes
                      });
                    },
                  ),
                  const Text('Is Active'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _submitSchedule,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
