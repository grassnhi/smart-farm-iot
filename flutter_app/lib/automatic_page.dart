import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
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

  String getCurrentTimestamp() {
    final now = DateTime.now().toUtc().add(Duration(hours: 7)); // GMT+7
    final formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    return '${formatter.format(now)} GMT+0700';
  }

  void uploadSchedule() {
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

    // Send message to Firebase Realtime Database
    final databaseReference = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: "https://smartfarm-g3-default-rtdb.asia-southeast1.firebasedatabase.app/",
    ).ref().child("schedules").child(name);

    databaseReference.set(message).then((_) {
      print("Schedule uploaded to Firebase");
    }).catchError((error) {
      print("Failed to upload schedule to Firebase: $error");
    });
  }

  void deleteSchedule() {
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
  const AutomaticPage({Key? key}) : super(key: key);

  @override
  _AutomaticPageState createState() => _AutomaticPageState();
}

class _AutomaticPageState extends State<AutomaticPage> {
  final _formKey = GlobalKey<FormState>();
  final Schedule schedule = Schedule();

  void _submitSchedule() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      schedule.uploadSchedule();
      schedule.deleteSchedule();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Schedule submitted successfully!')),
      );
    }
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
          child: Form(
            key: _formKey,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a scheduler name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    schedule.name = value!;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Start Time (hh:mm)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a start time';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    schedule.startTime = value!;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'End Time (hh:mm)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an end time';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    schedule.endTime = value!;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Cycle Time (minutes)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a cycle time';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    schedule.cycleTime = int.parse(value!);
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Flow 1 (seconds)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a flow time for flow 1';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    schedule.flow1 = int.parse(value!);
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Flow 2 (seconds)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a flow time for flow 2';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    schedule.flow2 = int.parse(value!);
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Flow 3 (seconds)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a flow time for flow 3';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    schedule.flow3 = int.parse(value!);
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: schedule.isActive,
                      onChanged: (value) {
                        setState(() {
                          schedule.isActive = value ?? false;
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
      ),
    );
  }
}
