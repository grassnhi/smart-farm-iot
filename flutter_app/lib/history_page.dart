import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final databaseReference = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://smartfarm-g3-default-rtdb.asia-southeast1.firebasedatabase.app/",
  ).ref().child("schedules");

  List<Map<String, dynamic>> schedules = [];

  @override
  void initState() {
    super.initState();
    _fetchSchedules();
  }

  void _fetchSchedules() {
    databaseReference.once().then((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          schedules = data.entries.map((entry) {
            return {
              "name": entry.key,
              "startTime": entry.value["startTime"],
              "endTime": entry.value["stopTime"],
            };
          }).toList();
        });
      }
    }).catchError((error) {
      print("Failed to load schedules: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Page'),
      ),
      body: schedules.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          return ListTile(
            leading: Icon(Icons.schedule, color: Colors.blue),
            title: Text(
              "Scheduler '${schedule["name"]}'",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Start time: ${schedule["startTime"]}, End time: ${schedule["endTime"]}",
            ),
          );
        },
      ),
    );
  }
}
