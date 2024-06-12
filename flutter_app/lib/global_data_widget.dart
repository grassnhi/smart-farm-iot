// lib/global_data_widget.dart
import 'package:flutter/material.dart';
// lib/global_data.dart
import 'package:flutter/foundation.dart';

class GlobalData extends ChangeNotifier {
  String _temperature = "0°C";
  String _humidity = "0%";

  String get temperature => _temperature;
  String get humidity => _humidity;

  void updateData(String newTemperature, String newHumidity) {
    _temperature = newTemperature;
    _humidity = newHumidity;
    notifyListeners();
  }
}


class GlobalDataWidget extends StatefulWidget {
  const GlobalDataWidget({Key? key}) : super(key: key);

  @override
  _GlobalDataWidgetState createState() => _GlobalDataWidgetState();

  static _GlobalDataWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<_GlobalDataWidgetState>()!;
  }
}

class _GlobalDataWidgetState extends State<GlobalDataWidget> {
  String temperature = "0°C";
  String humidity = "0%";

  void updateData(String newTemperature, String newHumidity) {
    setState(() {
      temperature = newTemperature;
      humidity = newHumidity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Temperature: $temperature'),
        Text('Humidity: $humidity'),
      ],
    );
  }
}