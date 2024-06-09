import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<String> historyItems = [
    'Watered plants on 2024-06-01',
    'Fertilized crops on 2024-06-02',
  ];

  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView.builder(
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.history),
            title: Text(historyItems[index]),
          );
        },
      ),
    );
  }
}
