import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothPage extends StatefulWidget {
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  BluetoothConnection? connection;
  bool isConnecting = true;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    connectToDevice('ESP32'); // Pass the device name as a parameter
  }

  void connectToDevice(String deviceName) async {
    try {
      List<BluetoothDevice> devices =
          await FlutterBluetoothSerial.instance.getBondedDevices();
      BluetoothDevice? device =
          devices.firstWhere((d) => d.name == deviceName, orElse: () => null);
      if (device == null) {
        print('Device not found');
        return;
      }
      BluetoothConnection newConnection =
          await BluetoothConnection.toAddress(device.address);
      print('Connected to device');
      setState(() {
        connection = newConnection;
        isConnecting = false;
        isConnected = true;
      });
    } catch (error) {
      print('Error connecting to device: $error');
      setState(() {
        isConnecting = false;
        isConnected = false;
      });
    }
  }

  void sendData(String data) {
    if (connection != null && connection!.isConnected) {
  connection!.output.add(utf8.encode(data));
      connection!.output.allSent.then((_) {
        print('Data sent: $data');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isConnected ? 'Connected' : 'Not Connected',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: isConnected ? () => sendData('Hello, ESP32!') : null,
              child: Text('Send Data'),
            ),
          ],
        ),
      ),
    );
  }
}
