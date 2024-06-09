import 'package:flutter/material.dart';

class NotiPage extends StatelessWidget {
  final List<String> notifications = [
    'Scheduler 1 finishes with 1 error!',
    'Water pump-in process stopped due to no water.',
    'Scheduler 1 is executing ...',
  ];

  NotiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.notifications),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 4), 
                child: Text(notifications[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
