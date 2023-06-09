import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothPage extends StatefulWidget {
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  BluetoothDevice? device;
  BluetoothCharacteristic? characteristic;
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    connectToDevice();
  }

  void connectToDevice() async {
    device = await FlutterBlue.instance
        .scan(timeout: Duration(seconds: 4))
        .firstWhere((scanResult) => scanResult.device.name == 'esp32')
        .then((scanResult) => scanResult.device);

    if (device != null) {
      await device!.connect();

      List<BluetoothService> services = await device!.discoverServices();
      services.forEach((service) {
        if (service.uuid.toString() == 'f8a53b62-34b7-4bbf-884f-179c2d8b8495') {
          service.characteristics.forEach((characteristic) {
            if (characteristic.uuid.toString() ==
                'c9db152e-9f0b-437d-97e9-8ad362191d7b') {
              this.characteristic = characteristic;
              setState(() {});
            }
          });
        }
      });
    }

    if (characteristic != null) {
      subscription = characteristic!.value.listen((value) {
        String receivedData = utf8.decode(value);
        print('Received data: $receivedData');
      });
    }
  }

  void sendData(String data) {
    if (characteristic != null) {
      List<int> bytes = utf8.encode(data);
      characteristic!.write(Uint8List.fromList(bytes));
    }
  }

  @override
  void dispose() {
    subscription?.cancel();
    device?.disconnect();
    super.dispose();
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
          children: [
            ElevatedButton(
              onPressed: () => sendData('Hello, ESP32!'),
              child: Text('Send Data'),
            ),
            SizedBox(height: 16),
            Text('Received Data:'),
            StreamBuilder<List<int>>(
              stream: characteristic?.value,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String receivedData = utf8.decode(snapshot.data!);
                  return Text(receivedData);
                } else {
                  return Text('No Data');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
