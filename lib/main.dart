import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Battery Level by Native'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  int _counter = 0;
  // Get battery level.
  String batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String _batteryLevel;
    int result;
    try {
      print("get battery level");
      result = await platform.invokeMethod('getBatteryLevel');
      _batteryLevel = 'Battery level at $result% .';
      print(_batteryLevel);
    } on PlatformException catch (e) {
      _batteryLevel = "Failed to get battery level: '${e.message}'.";
      print(_batteryLevel);
    }

    setState(() {
      batteryLevel = _batteryLevel;
      _counter = result;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Your Mobile Phone $batteryLevel'),
            Text(
              '$_counter%',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getBatteryLevel, // _incrementCounter,
        tooltip: 'batteryLevel', // 'Increment',
        child: Icon(Icons.battery_unknown),
      ),
    );
  }
}
